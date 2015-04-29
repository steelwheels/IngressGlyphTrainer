/**
 * @file	MainViewController.m
 * @brief	Define MainViewController class
 * @par Copyright
 *   Copyright (C) 2015 Steel Wheels Project
 */

#import "MainViewController.h"
#import "MainStateMachine.h"
#import "MainModel.h"
#import <KGGlyphGraphics/KGGlyphGraphics.h>

@interface MainViewController ()
- (void) moveToSetupViewButtonPressed: (UIBarButtonItem *) item ;
- (void) moveToAboutViewButtonPressed: (UIBarButtonItem *) item ;
- (void) startButtonPressed: (KGStartButton *) button ;
@end

@interface MainViewController (GlyphSequenceSupport) <KGGlyphSequenceEditiing>
@end

@implementation MainViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.moveToSetupViewButton.target = self ;
	self.moveToSetupViewButton.action = @selector(moveToSetupViewButtonPressed:) ;
	
	self.moveToAboutViewButton.target = self ;
	self.moveToAboutViewButton.action = @selector(moveToAboutViewButtonPressed:) ;
	
	[self.startButton addTarget: self
			     action: @selector(startButtonPressed:)
		   forControlEvents: UIControlEventTouchUpInside] ;
	
	KGGameStatus * status = [MainModel sharedStatus] ;
	[status addStateObserver: self.startButton] ;
	[status addStateObserver: self.glyphNameLabel] ;
	
	[self.navigationBar setupProgressBar] ;
	KGHackProgressView * progressview = [self.navigationBar progressView] ;
	[status addStateObserver: progressview] ;

	MainStateMachine * statemachine = [MainModel sharedStateMachine] ;
	[self.glyphSequenceView setDelegate: statemachine] ;
	[status addStateObserver: self.glyphSequenceView] ;
	
	[self.timerLabel clearTimerLabel] ;
	[status addStateObserver: self.timerLabel] ;
	
	/* initialize the state */
	status.state = KGIdleState ;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void) moveToSetupViewButtonPressed: (UIBarButtonItem *) item
{
	(void) item ;
	puts("moveToSetupViewButtonPressed:") ;
	[self performSegueWithIdentifier: @"SegueFromMainToSetup" sender: self] ;
}

- (void) moveToAboutViewButtonPressed: (UIBarButtonItem *) item
{
	(void) item ;
	puts("moveToAboutViewButtonPressed: ") ;
	[self performSegueWithIdentifier: @"SegueFromMainToAbout" sender: self] ;
}

- (void) startButtonPressed: (KGStartButton *) button
{
	(void) button ;
	puts("Start button pressed") ;
	MainStateMachine * statemachine = [MainModel sharedStateMachine] ;
	[statemachine start] ;
}

@end

@implementation MainViewController (GlyphSequenceSupport)

- (void) glyphEditingEnded: (const struct KGGlyphStroke *) stroke
{
	MainStateMachine * statemachine = [MainModel sharedStateMachine] ;
	[statemachine glyphEditingEnded: stroke] ;
}

- (void) glyphEditingCancelled
{
	MainStateMachine * statemachine = [MainModel sharedStateMachine] ;
	[statemachine glyphEditingCancelled] ;
}

@end


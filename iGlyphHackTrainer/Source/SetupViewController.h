/**
 * @file	SetupViewController.h
 * @brief	Define SetupViewController class
 * @par Copyright
 *   Copyright (C) 2015 Steel Wheels Project
 */

#import <KCSwitch/KCSwitch.h>

@interface SetupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backToMainViewButton;
@property (weak, nonatomic) IBOutlet KCSwitch *doDisplayInputGlypuNameSwitch;

- (void) backToMainViewButtonPressed: (UIBarButtonItem *) item ;

@end

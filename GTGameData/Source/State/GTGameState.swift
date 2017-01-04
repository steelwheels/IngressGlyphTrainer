/**
 * @file	GTGameState.m
 * @brief	Define GTGameState
 * @par Copyright
 *   Copyright (C) 2015-2016 Steel Wheels Project
 */

import Canary

public enum GTScene {
	case StartScene
	case QuestionScene
	case AnswerScene
	case CheckScene

	public var description: String {
		get {
			var result: String = "unknown"
			switch self {
			case .StartScene:	result = "start"
			case .QuestionScene:	result = "question"
			case .AnswerScene:	result = "answer"
			case .CheckScene:	result = "check"
			}
			return result
		}
	}
}

public class GTGameState: CNState
{
	public static let NO_PROGRESS		: Int = -1

	private var mScene		: GTScene
	private var mPrevScene		: GTScene
	private var mGlyphSequence	: Array<GTGlyphCharacter>
	private var mGlyphProgress	: Int

	public var scene: GTScene {
		get {
			return mScene
		}
		set(newscene){
			if mScene != newscene {
				mPrevScene = mScene
				mScene = newscene
				transitScene(scene: newscene)
				self.updateState()
			}
		}
	}

	public var previousScene: GTScene {
		get { return mPrevScene }
	}
	
	public override init(){
		mScene		= .StartScene
		mPrevScene	= .StartScene
		mGlyphSequence	= []
		mGlyphProgress	= GTGameState.NO_PROGRESS
		
		super.init()
		transitScene(scene: .StartScene)
	}

	private func transitScene(scene newScene: GTScene) -> Void
	{
		switch newScene {
		case .StartScene:
			mGlyphSequence = selectSequence()
			mGlyphProgress = GTGameState.NO_PROGRESS
		case .QuestionScene:
			mGlyphProgress = GTGameState.NO_PROGRESS
			break
		case .AnswerScene:
			mGlyphProgress = GTGameState.NO_PROGRESS
			break
		case .CheckScene:
			mGlyphProgress = GTGameState.NO_PROGRESS
			break
		}
	}

	private func selectSequence() -> Array<GTGlyphCharacter>
	{
		return []
	}

	public var glyphSequence: Array<GTGlyphCharacter> {
		get { return mGlyphSequence }
	}

	public var glyphProgress: Int {
		get { return mGlyphProgress }
	}

	public func incrementGlyphProgress(){
		if 0<=mGlyphProgress && mGlyphProgress<mGlyphSequence.count-1 {
			mGlyphProgress += 1
		} else if mGlyphProgress == GTGameState.NO_PROGRESS {
			mGlyphProgress = 0
		} else {
			mGlyphProgress = GTGameState.NO_PROGRESS
		}
		self.updateState()
	}
}



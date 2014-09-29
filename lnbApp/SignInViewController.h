//
//  SignInViewController.h
//  lnbApp
//
//  Created by Yves Benchimol on 28/09/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "parse-library-1.4.1/Parse.framework/Headers/Parse.h"


@interface SignInViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

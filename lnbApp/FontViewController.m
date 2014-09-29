//
//  FontViewController.m
//  lnbApp
//
//  Created by Yves Benchimol on 27/09/2014.
//  Copyright (c) 2014 Yves Benchimol. All rights reserved.
//

#import "FontViewController.h"
#import "SWRevealViewController.h"
#import "StatsViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface FontViewController ()

@end

@implementation FontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        StatsViewController *statsViewController = [[StatsViewController alloc] init];
        UIViewController *newFrontController = [[UINavigationController alloc] initWithRootViewController:statsViewController];
        [self.revealViewController pushFrontViewController:newFrontController animated:YES];
    } else {
        //sign in and sign up viewController
        PFLogInViewController *loginViewController = [[PFLogInViewController alloc] init];
        loginViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsFacebook | PFLogInFieldsSignUpButton;
        loginViewController.delegate = self;
        loginViewController.signUpController.delegate = self;
        
        [self presentViewController:loginViewController animated:YES completion:nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Delegate PFlogin

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

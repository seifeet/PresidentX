//
//  MultiGraphViewController.m
//  PresidentX
//
//  Created by Anil Narasipuram on 9/13/12.
//  Copyright (c) 2012 AOL Hatch Day. All rights reserved.
//

#import "MultiGraphViewController.h"

@interface MultiGraphViewController ()

@end

@implementation MultiGraphViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  [self.navigationController setNavigationBarHidden:YES];
  
  UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  closeButton.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
  [closeButton setImage:[UIImage imageNamed:@"icon_close.png"] forState:UIControlStateNormal];
  [closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:closeButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)closeButtonPressed
{
  [self.navigationController popViewControllerAnimated:YES];
}

@end

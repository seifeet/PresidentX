//
//  ViewController.m
//  AOLHatch
//
//  Created by Anil Narasipuram on 9/13/12.
//  Copyright (c) 2012 Anil Narasipuram. All rights reserved.
//

#import <ShinobiCharts/ShinobiChart.h>
#import "ViewController.h"
#import "CandidateProfileViewController.h"

@interface ViewController ()

- (IBAction)obamaProfilePressed:(id)sender;
- (IBAction)romneyProfilePressed:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)obamaProfilePressed:(id)sender
{
  CandidateProfileViewController *candidateVC = [[CandidateProfileViewController alloc] initWithNibName:@"CandidateProfileViewController" bundle:nil];
  candidateVC.candidate = @"obama";
  [self.navigationController pushViewController:candidateVC animated:YES];
}

- (IBAction)romneyProfilePressed:(id)sender
{
  CandidateProfileViewController *candidateVC = [[CandidateProfileViewController alloc] initWithNibName:@"CandidateProfileViewController" bundle:nil];
  candidateVC.candidate = @"romney";
  [self.navigationController pushViewController:candidateVC animated:YES];
}



@end

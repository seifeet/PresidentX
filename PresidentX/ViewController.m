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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
  self.navigationController.navigationBar.translucent = YES;
  UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
//  [self.navigationController.navigationItem.titleView addSubview:headerView];
//  self.navigationController.navigationBar ;
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  UITouch *touch = [touches anyObject];
  CGPoint point = [touch locationInView:self.view];
  if (point.y < 252.0)
  {
    CandidateProfileViewController *candidateVC = [[CandidateProfileViewController alloc] initWithNibName:@"CandidateProfileViewController" bundle:nil];
    candidateVC.candidate = @"obama";
    [self.navigationController pushViewController:candidateVC animated:YES];
  }
  else
  {
    CandidateProfileViewController *candidateVC = [[CandidateProfileViewController alloc] initWithNibName:@"CandidateProfileViewController" bundle:nil];
    candidateVC.candidate = @"romney";
    [self.navigationController pushViewController:candidateVC animated:YES];
  }
}

@end

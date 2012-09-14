//
//  CandidateProfileViewController.m
//  AOLHatch
//
//  Created by Anil Narasipuram on 9/13/12.
//  Copyright (c) 2012 Anil Narasipuram. All rights reserved.
//
#import <ShinobiCharts/ShinobiChart.h>
#import "CandidateProfileViewController.h"
#import "MultiGraphViewController.h"
#import "parseCSV.h"
#import "LineChartDataSource.h"

@interface CandidateProfileViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *profileImage;
@property (nonatomic, strong) NSMutableArray *series1Data, *series1Dates;
@property (nonatomic, strong) LineChartDataSource *dataSource;

@end

@implementation CandidateProfileViewController

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
  
  self.view.backgroundColor = [UIColor colorWithRed:255.f/255.f green:248.f/255.f blue:228.f/255.f alpha:1.f];
  if ([self.candidate isEqualToString:@"obama"])
  {
    self.profileImage.image = [UIImage imageNamed:@"obama_candidate"];
  }
  else{
    self.profileImage.image = [UIImage imageNamed:@"romney_candidate"];

  }
  
    //  CGRect chartFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-50);
    CGRect chartFrame = CGRectMake(0.0, 200.0, 320.0, 260.0);
  
  
    
    [self createChartWithFrame:chartFrame];
}

- (void)viewWillAppear:(BOOL)animated
{
  [self.navigationController setNavigationBarHidden:NO];
  [super viewWillAppear:animated];
}

-(void)createChartWithFrame:(CGRect)frame
{
  
  ShinobiChart *chart = [[ShinobiChart alloc] initWithFrame:frame withTheme: [[SChartMidnightTheme alloc] init] withPrimaryXAxisType:SChartAxisTypeDateTime withPrimaryYAxisType:SChartAxisTypeNumber];
  //As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
  chart.autoresizingMask = ~UIViewAutoresizingNone;
  
  // Initialise a datasource and give it to the chart
  self.dataSource = [[LineChartDataSource alloc] init];
  chart.datasource = self.dataSource;
  
  // Set this object as the delegate for the chart
  chart.delegate = self;
  
  // Chart Title
//  chart.title = @"Large Data Set - 20,000 Points";
  chart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];
  chart.titleLabel.textColor = [UIColor whiteColor];
  
  // Customize xAxis
  chart.xAxis.enableGesturePanning = YES;
  chart.xAxis.enableGestureZooming = YES;
  chart.xAxis.enableMomentumPanning = YES;
  chart.xAxis.enableMomentumZooming = YES;
  chart.xAxis.axisPositionValue = @(0);
  chart.xAxis.tickLabelClippingModeLow = SChartTickLabelClippingModeTicksPersist;
  
  // Customize yAxis
  chart.yAxis.enableGesturePanning = YES;
  chart.yAxis.enableGestureZooming = YES;
  chart.yAxis.enableMomentumPanning = YES;
  chart.yAxis.enableMomentumZooming = YES;
  
  // Set default ranges on the axes
//  chart.xAxis.defaultRange = [[SChartNumberRange alloc] initWithMinimum:[NSNumber numberWithInt: 3694] andMaximum:[NSNumber numberWithInt:3821]];
//  chart.yAxis.defaultRange = [[SChartNumberRange alloc] initWithMinimum:[NSNumber numberWithInt: 175] andMaximum:[NSNumber numberWithInt:325]];
  
//  chart.yAxis.tickLabelClippingModeLow = SChartTickLabelClippingModeTicksPersist;
//  chart.yAxis.tickLabelClippingModeHigh = SChartTickLabelClippingModeTicksPersist;
  
  // Enable the double-tap-to-reset gesture
  chart.gestureDoubleTapResetsZoom = YES;
  
  // Customize the Legend
//  chart.legend.hidden = NO;
//  chart.legend.style.font = [UIFont fontWithName:@"Futura" size:17.0f];
//  chart.legend.symbolWidth = @(75);
//  chart.legend.style.borderColor = [UIColor clearColor];
  
  // If you have a trial version, you need to enter your licence key here:
  chart.licenseKey = LICENSE_KEY;
    
  // Add the chart to the view controller
  [self.view addSubview:chart];
}

// Alter tickmarks before they're added to the axes
-(void)sChart:(ShinobiChart *)c alterTickMark:(SChartTickMark *)tickMark beforeAddingToAxis:(SChartAxis *)axis {
  
  // Move the labels of the tickmarks on the yAxis over the plot area
  if (axis == c.yAxis) {
    CGRect tickLabelFrame = tickMark.tickLabel.frame;
    tickLabelFrame.origin.x += [axis spaceRequiredToDrawWithTitle: NO] + 5.f;
    tickMark.tickLabel.frame = tickLabelFrame;
  }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)fullScreenGraph:(id)sender
{
  MultiGraphViewController *multiGraph = [[MultiGraphViewController alloc] initWithNibName:@"MultiGraphViewController" bundle:nil];
  [self.navigationController pushViewController:multiGraph animated:YES];
}

@end

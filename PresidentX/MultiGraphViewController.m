//
//  MultiGraphViewController.m
//  PresidentX
//
//  Created by Anil Narasipuram on 9/13/12.
//  Copyright (c) 2012 AOL Hatch Day. All rights reserved.
//

#import <ShinobiCharts/ShinobiChart.h>
#import "MultiGraphViewController.h"
#import "TwitterTopicsDataSource.h"
#import "DayViewController.h"
#import "LineChartDataSource.h"
#import "parseCSV.h"

@interface MultiGraphViewController ()

@property (nonatomic, strong) NSMutableArray *series1Data, *series1Dates;
@property (nonatomic, strong) TwitterTopicsDataSource *dataSource;
@property (nonatomic, strong) LineChartDataSource *ldataSource;

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
  
  // Do any additional setup after loading the view from its nib.
  self.view.backgroundColor = [UIColor colorWithRed:26.f/255.f green:25.f/255.f blue:25.f/255.f alpha:1.f];
  
  CGRect chartFrame = CGRectMake(0.0, 2.0, self.view.bounds.size.width, self.view.bounds.size.height);
  
  [self createChartWithFrame:chartFrame];
  
  UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  closeButton.frame = CGRectMake(self.view.bounds.size.width - 37.0, 0.0, 37.0, 37.0);
  [closeButton setImage:[UIImage imageNamed:@"icon_close.png"] forState:UIControlStateNormal];
  [closeButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:closeButton];
}

- (void)viewWillAppear:(BOOL)animated
{
  [UIViewController attemptRotationToDeviceOrientation];
  [super viewWillAppear:animated];
}

- (void)createChartWithFrame:(CGRect)frame
{
    
    ShinobiChart *chart = [[ShinobiChart alloc] initWithFrame:frame withTheme: [[SChartMidnightTheme alloc] init] withPrimaryXAxisType:SChartAxisTypeDateTime withPrimaryYAxisType:SChartAxisTypeNumber];
    //As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
    chart.autoresizingMask = ~UIViewAutoresizingNone;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.candidate == @"obama" ? @"obama_twitter" : @"romney_twitter" ofType:@"csv"];
    
    self.dataSource = [[TwitterTopicsDataSource alloc] initWithPath:path];
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
    
    // Enable the double-tap-to-reset gesture
    chart.gestureDoubleTapResetsZoom = NO;
    
    // If you have a trial version, you need to enter your licence key here:
    chart.licenseKey = LICENSE_KEY;
    
    // Add the chart to the view controller
    [self.view addSubview:chart];
}

// Alter tickmarks before they're added to the axes
-(void)sChart:(ShinobiChart *)c alterTickMark:(SChartTickMark *)tickMark beforeAddingToAxis:(SChartAxis *)axis {
    
//    // Move the labels of the tickmarks on the yAxis over the plot area
//    if (axis == c.yAxis) {
//        CGRect tickLabelFrame = tickMark.tickLabel.frame;
//        tickLabelFrame.origin.x += [axis spaceRequiredToDrawWithTitle: NO] + 5.f;
//        tickMark.tickLabel.frame = tickLabelFrame;
//    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    return YES;
  else
    return NO;
}

- (void)closeButtonPressed
{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//  DayViewController *dayVC = [[DayViewController alloc] init];
//  dayVC.candidate = @"obama";
//  [self.navigationController pushViewController:dayVC animated:NO];
}

@end

//
//  TwitterTopicsDataSource.m
//  PresidentX
//
//  Created by Anil Narasipuram on 9/14/12.
//  Copyright (c) 2012 AOL Hatch Day. All rights reserved.
//

#import "TwitterTopicsDataSource.h"

@interface TwitterTopicsDataSource ()

@property (nonatomic, strong) NSMutableArray *seriesDates, *series1Data, *series2Data, *series3Data, *series4Data, *series0Data;
@property (nonatomic, strong) NSString *path;

@end

@implementation TwitterTopicsDataSource

- (void)readCandidateData
{
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
  
  CSVParser *parser = [CSVParser new];
  [parser openFile:self.path];
  NSMutableArray *csvContent = [parser parseFile];
  NSInteger lineNumber;
  for (lineNumber = 1; lineNumber < [csvContent count]; ++lineNumber)
  {
    NSArray *line = [csvContent objectAtIndex: lineNumber];
    if (line) {
      NSString *dateStr = [line objectAtIndex:0];
      NSString *priceStr = [line objectAtIndex:1];
      NSString *overallStr = [line objectAtIndex:2];
      NSString *abortionStr = [line objectAtIndex:3];
      NSString *economyStr = [line objectAtIndex:4];
      NSString *healthcareStr = [line objectAtIndex:5];
      
      if (dateStr && priceStr)
      {
        NSDate *date = [dateFormatter dateFromString: priceStr];
        NSNumber *priceCount = @(floor([priceStr doubleValue]));
        
        if (date && priceCount)
        {
          [self.seriesDates addObject:date];
          [self.series0Data addObject:priceCount];
        }
      }
      if (dateStr && overallStr)
      {
        NSDate *date = [dateFormatter dateFromString: dateStr];
        NSNumber *overallCount = @([overallStr intValue] / 100);
        
        if (date && overallCount)
        {
          [self.seriesDates addObject:date];
          [self.series1Data addObject:overallCount];
        }
      }
      if (dateStr && abortionStr)
      {
        NSDate *date = [dateFormatter dateFromString: dateStr];
        NSNumber *abortionCount = @([abortionStr intValue]);
        
        if (date && abortionCount)
        {
          [self.seriesDates addObject:date];
          [self.series2Data addObject:abortionCount];
        }
      }
      if (dateStr && economyStr)
      {
        NSDate *date = [dateFormatter dateFromString: dateStr];
        NSNumber *economyCount = @([economyStr intValue]);
        
        if (date && economyCount)
        {
          [self.seriesDates addObject:date];
          [self.series3Data addObject:economyCount];
        }
      }
      if (dateStr && healthcareStr)
      {
        NSDate *date = [dateFormatter dateFromString: dateStr];
        NSNumber *healthcareCount = @([healthcareStr intValue]);
        
        if (date && healthcareCount)
        {
          [self.seriesDates addObject:date];
          [self.series4Data addObject:healthcareCount];
        }
      }
    }
  }
  [parser closeFile];
}

- (id)initWithPath:(NSString *)path
{
  self = [super init];
  if (self)
  {
    _path = path;
    _seriesDates = [[NSMutableArray alloc] init];
    _series0Data = [[NSMutableArray alloc] init];
    _series1Data = [[NSMutableArray alloc] init];
    _series2Data = [[NSMutableArray alloc] init];
    _series3Data = [[NSMutableArray alloc] init];
    _series4Data = [[NSMutableArray alloc] init];
    
    [self readCandidateData];
  }
  return self;
}

#pragma mark -
#pragma mark Datasource Protocol Functions

// Returns the number of points for a specific series in the specified chart
- (int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
  
  // In our example, all series have the same number of points
    switch (seriesIndex)
    {
        case 0:
            return [self.series0Data count];
            break;
        case 1:
            return [self.series1Data count];
            break;
        case 2:
            return [self.series2Data count];
            break;
        case 3:
            return [self.series3Data count];
            break;
        case 4:
            return [self.series4Data count];
            break;
        default:
            break;
    }
    return 0;
}

// Returns the series at the specified index for a given chart
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index
{
    BOOL stepLineMode = NO;
    // Our series are either of type SChartLineSeries or SChartStepLineSeries depending on stepLineMode.
    SChartLineSeries *lineSeries = stepLineMode? [[SChartStepLineSeries alloc] init]: [[SChartLineSeries alloc] init];
    
    lineSeries.style.lineWidth = [NSNumber numberWithInt: 2];
    
    switch (index) {
        case 0:
            lineSeries.style.lineColor = [UIColor colorWithRed:255.f/215.f green:0.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColor = [UIColor colorWithRed:238.f/255.f green:211.f/255.f blue:130.f/255.f alpha:1.f];
            
            lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:227.f/255.f green:182.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:150.f/255.f green:120.f/255.f blue:0.f alpha:1.f];
            break;
            
        case 1:
            lineSeries.style.lineColor = [UIColor colorWithRed:80.f/255.f green:151.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColor = [UIColor colorWithRed:90.f/255.f green:131.f/255.f blue:10.f/255.f alpha:1.f];
            
            lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:227.f/255.f green:182.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:150.f/255.f green:120.f/255.f blue:0.f alpha:1.f];
            break;
            
        case 2:
            lineSeries.style.lineColor = [UIColor colorWithRed:255.f/215.f green:0.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColor = [UIColor colorWithRed:238.f/255.f green:211.f/255.f blue:130.f/255.f alpha:1.f];
            
            lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:227.f/255.f green:182.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:150.f/255.f green:120.f/255.f blue:0.f alpha:1.f];
            break;
            
        case 3:
            lineSeries.style.lineColor = [UIColor colorWithRed:80.f/255.f green:151.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColor = [UIColor colorWithRed:90.f/255.f green:131.f/255.f blue:10.f/255.f alpha:1.f];
            
            lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:227.f/255.f green:182.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:150.f/255.f green:120.f/255.f blue:0.f alpha:1.f];
            break;
            
        case 4:
            lineSeries.style.lineColor = [UIColor colorWithRed:80.f/255.f green:151.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColor = [UIColor colorWithRed:90.f/255.f green:131.f/255.f blue:10.f/255.f alpha:1.f];
            
            lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:227.f/255.f green:182.f/255.f blue:0.f alpha:1.f];
            lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:150.f/255.f green:120.f/255.f blue:0.f alpha:1.f];
            break;
            
        default:
            break;
    }
    
    
    lineSeries.baseline = [NSNumber numberWithInt:0];
    lineSeries.style.showFill = YES;
    
    lineSeries.crosshairEnabled = YES;
    
    return lineSeries;
}

// Returns the number of series in the specified chart
- (int)numberOfSeriesInSChart:(ShinobiChart *)chart {
  return 5;
}

// Returns the data point at the specified index for the given series/chart.
- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex
{
  // Construct a data point to return
  SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
  
  // For this example, we simply move one day forward for each dataIndex
  datapoint.xValue = [self.seriesDates objectAtIndex:dataIndex];
  
  // Construct an NSNumber for the yValue of the data point
  switch (seriesIndex)
  {
    case 0:
      datapoint.yValue = @([[self.series0Data objectAtIndex:dataIndex] floatValue]);
      break;
    case 1:
      datapoint.yValue = @([[self.series1Data objectAtIndex:dataIndex] floatValue]);
      break;
    case 2:
      datapoint.yValue = @([[self.series2Data objectAtIndex:dataIndex] floatValue]);
      break;
    case 3:
      datapoint.yValue = @([[self.series3Data objectAtIndex:dataIndex] floatValue]);
      break;
    case 4:
      datapoint.yValue = @([[self.series4Data objectAtIndex:dataIndex] floatValue]);
      break;
    default:
      break;
  }
  
  return datapoint;
}


@end

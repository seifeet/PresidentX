//
//  LineChartDataSource.m
//  LineChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import "LineChartDataSource.h"
#import "parseCSV.h"

@interface LineChartDataSource ()

@property (nonatomic, strong) NSMutableArray *series1Data, *series1Dates;
@property (nonatomic, strong) NSString *path;

@end

@implementation LineChartDataSource

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
            NSString *obamaStr = [line objectAtIndex:1];
            
            if (dateStr && obamaStr)
            {
                NSDate *date = [dateFormatter dateFromString: dateStr];
                NSNumber *obamaCount = [NSNumber numberWithInt:[obamaStr intValue]];
            
                if (date && obamaCount)
                {
                    [self.series1Dates addObject:date];
                    [self.series1Data addObject:obamaCount];
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
      _series1Data = [[NSMutableArray alloc] init];
      _series1Dates = [[NSMutableArray alloc] init];
      
      [self readCandidateData];
    }
    return self;
}

#pragma mark -
#pragma mark Datasource Protocol Functions

// Returns the number of points for a specific series in the specified chart
- (int)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(int)seriesIndex {
    
    // In our example, all series have the same number of points
    return [self.series1Data count];
}

// Returns the series at the specified index for a given chart
-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(int)index
{
    
  BOOL stepLineMode = NO;
    // Our series are either of type SChartLineSeries or SChartStepLineSeries depending on stepLineMode.
  SChartLineSeries *lineSeries = stepLineMode? [[SChartStepLineSeries alloc] init]: [[SChartLineSeries alloc] init];
    
    lineSeries.style.lineWidth = [NSNumber numberWithInt: 2];
    
    lineSeries.style.lineColor = [UIColor colorWithRed:80.f/255.f green:151.f/255.f blue:0.f alpha:1.f];
    lineSeries.style.areaColor = [UIColor colorWithRed:90.f/255.f green:131.f/255.f blue:10.f/255.f alpha:1.f];
    
    lineSeries.style.lineColorBelowBaseline = [UIColor colorWithRed:227.f/255.f green:182.f/255.f blue:0.f alpha:1.f];
    lineSeries.style.areaColorBelowBaseline = [UIColor colorWithRed:150.f/255.f green:120.f/255.f blue:0.f alpha:1.f];
    
    lineSeries.baseline = [NSNumber numberWithInt:0];
    lineSeries.style.showFill = YES;
    
    lineSeries.crosshairEnabled = YES;
    
    return lineSeries;
}

// Returns the number of series in the specified chart
- (int)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1;
}

// Returns the data point at the specified index for the given series/chart.
- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(int)dataIndex forSeriesAtIndex:(int)seriesIndex
{
    // Construct a data point to return
    SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
    
    // For this example, we simply move one day forward for each dataIndex
    datapoint.xValue = [self.series1Dates objectAtIndex:dataIndex];
    
    // Construct an NSNumber for the yValue of the data point

  datapoint.yValue = @([[self.series1Data objectAtIndex:dataIndex] floatValue]);
    
    return datapoint;
}

@end

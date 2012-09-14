//
//  LineChartDataSource.h
//  LineChart
//
//  Copyright 2011 Scott Logic Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiChart.h>
#import "parseCSV.h"

@interface LineChartDataSource : NSObject <SChartDatasource>

- (id)initWithPath:(NSString *)path;

@end

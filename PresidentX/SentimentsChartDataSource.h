//
//  SentimentsChartDataSource.h
//  PresidentX
//
//  Created by Anil Narasipuram on 9/14/12.
//  Copyright (c) 2012 AOL Hatch Day. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShinobiCharts/ShinobiChart.h>
#import "parseCSV.h"

@interface SentimentsChartDataSource : NSObject <SChartDatasource>

- (id)initWithPath:(NSString *)path;

@end

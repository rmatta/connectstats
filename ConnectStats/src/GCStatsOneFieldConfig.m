//  MIT Licence
//
//  Created on 25/08/2014.
//
//  Copyright (c) 2014 Brice Rosenzweig.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//  

#import "GCStatsOneFieldConfig.h"
#import "GCStatsMultiFieldConfig.h"
@interface GCStatsOneFieldConfig ()
@end

@implementation GCStatsOneFieldConfig
+(GCStatsOneFieldConfig*)configFromMultiFieldConfig:(GCStatsMultiFieldConfig*)multiFieldConfig{
    GCStatsOneFieldConfig * rv  = [[[GCStatsOneFieldConfig alloc] init] autorelease];
    if(rv){
        rv.calendarConfig = multiFieldConfig.calendarConfig;
    }
    return rv;
}
-(void)dealloc{
    [_activityType release];
    [_x_field release];
    [_fieldOrder release];
    [_field release];
    [_calendarConfig release];
    
    [super dealloc];
}

-(gcViewChoice)viewChoice{
    NSCalendarUnit unit = self.calendarConfig.calendarUnit;
    if(unit == NSCalendarUnitMonth){
        return gcViewChoiceMonthly;
    }else if(unit == NSCalendarUnitWeekOfYear){
        return gcViewChoiceWeekly;
    }else{
        return gcViewChoiceYearly;
    }
}
-(void)setViewChoice:(gcViewChoice)viewChoice{
    self.calendarConfig.calendarUnit = [GCViewConfig calendarUnitForViewChoice:viewChoice];
}
-(GCHistoryFieldDataSerieConfig*)historyConfig{
    return [GCHistoryFieldDataSerieConfig configWithField:_field xField:nil filter:_useFilter fromDate:nil];
}
-(GCHistoryFieldDataSerieConfig*)historyConfigXY{
    return [GCHistoryFieldDataSerieConfig configWithField:_field xField:_x_field filter:_useFilter fromDate:nil];

}
-(void)nextViewChoice{
    if (self.viewChoice == gcViewChoiceMonthly) {
        self.viewChoice = gcViewChoiceYearly;
    }else if(self.viewChoice == gcViewChoiceYearly){
        self.viewChoice = gcViewChoiceWeekly;
    }else {
        self.viewChoice = gcViewChoiceMonthly;
    }
}
@end

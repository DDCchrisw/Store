//
//  DDCContractInfoModel.m
//  DDC_Store
//
//  Created by DAN on 2017/10/21.
//  Copyright © 2017年 DDC. All rights reserved.
//

#import "DDCContractInfoModel.h"

@implementation DDCContractInfoModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    oldValue = [super mj_newValueFromOldValue:oldValue property:property];
    if([property.name isEqualToString:@"startTime"]||[property.name isEqualToString:@"endTime"])
    {
        if ([oldValue isKindOfClass:[NSString class]])
        {
            NSString * value = (NSString*)oldValue;
            return [Tools dateWithTimeInterval:value andDateFormatter:@"yyyy/MM/dd"];
        }
    }
    return oldValue;
}


- (NSString *)courseString
{
    NSMutableArray *arr = [NSMutableArray array];
    for (OffLineCourseModel *courseM in self.course) {
        [arr addObject:[NSString stringWithFormat:@"%@/%@次",courseM.categoryName,courseM.count]];
    }
    return [arr componentsJoinedByString:@" "];
}

- (NSString *)effectiveAddressString
{
    return self.effectiveCourseAddress.name;
}

@end

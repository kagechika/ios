//
//  Problem.h
//  Quiz
//
//  Created by okitokagechika on 2014/04/11.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Problem : NSObject

-(void)setQ:(NSString *)q withA:(int)a;
-(NSString *)getQ;
-(int)getA;
+(id)initProblem;

@end

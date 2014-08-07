//
//  Problem.m
//  Quiz
//
//  Created by okitokagechika on 2014/04/11.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "Problem.h"

@implementation Problem {
    //問題文
    NSString *question;
    //答え
    int answer;
}

//問題文と答えを格納
-(void)setQ:(NSString *)q withA:(int) a{
    question = q;
    answer = a;
}

//問題文を取得
-(NSString *)getQ{
    return question;
}

//答えを取得
-(int)getA{
    return answer;
}

//初期化(id)
+(id)initProblem{
    return [[self alloc] init];
}

@end

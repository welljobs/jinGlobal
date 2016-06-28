//
//  BalencePoint.m
//  jinGlobal
//
//  Created by 1GE on 16/6/28.
//  Copyright © 2016年 1GE. All rights reserved.
//

#import "BalencePoint.h"
#include<iostream>
using namespace std;

@implementation BalencePoint

- (NSInteger)getBalencePoint:(NSArray *)A{
    
    if (A.count == 0) {
        return -1;
    }
    int sumArray = 0;
    int sum_left = 0;
    int count = 0;
    //求数组的总和
    for(int i=0;i<A.count;i++)
    {
        sumArray += [A[i] intValue];
    }
    for(int i=0;i<A.count;i++)
    {
        sum_left += [A[i] intValue];
        if(sum_left == ((sumArray-sum_left)/2))
        {
            count++;
            NSLog(@"平衡点是 == %d",[A[i] intValue]);
        }
    }
    NSLog(@"平衡点共计 == %d 个",count);    return -1;
}
/**
 * 求数组index左边的和
 * @param A
 * @param idx
 * @return
 */
- (int) getSumLeft:(NSArray *)A index:(int)idx
{
    int left = 0;
    if(idx==0)
    {
        left = [A[0] intValue];
        return left;
    }
    
    for(int i=0;i<idx;i++)
    {
        left += [A[idx-1-i] intValue];
    }
    return left;
    
}
/**
 * 求数组右边的和
 * @param A
 * @param idx
 * @return
 */
- (int) getRightLeft:(NSArray *)A index:(int)idx
{
    
    int right = 0;
    if(idx==A.count-1)
    {
        right = [A[A.count-1] intValue];
        return right;
    }
    for(int i=idx+1;i<A.count;i++)
    {
        right += [A[i] intValue];
    }
    return right;
    
}
/**
 * 遍历数组，如果左边等于右边，则打印平衡点index
 * @param A
 */
- (void) balences:(NSArray *)A
{
    int sumAarry = 0;
    int sum_left = 0;
    int sum_right = 0;
    int count = 0;
    //求数组的总和
    for(int i=0;i<A.count;i++)
    {
        sumAarry += [A[i] intValue];
    }
    for(int i=0;i<A.count;i++)
    {
        sum_left = [self getSumLeft:A index:i];
        sum_right = [self getRightLeft:A index:i];
        if(sum_left == sum_right)
        {
            count++;
            NSLog(@"平衡点是 == %d",[A[i] intValue]);
        }
    }
    NSLog(@"平衡点共计 == %d 个",count);
}

@end

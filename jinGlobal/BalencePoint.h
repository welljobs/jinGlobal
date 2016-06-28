//
//  BalencePoint.h
//  jinGlobal
//
//  Created by 1GE on 16/6/28.
//  Copyright © 2016年 1GE. All rights reserved.
//

#import <Foundation/Foundation.h>

/*  --------------------------------------------------------
 *  数组的平衡点P需满足:
 *  A[0] + A[1] + ... + A[P-1] = A[P+1] + ... + A[N-2] + A[N-1] (0<=P<N).
 *
 *  大概思路：根据数组平衡点的定义，可以利用保存数组子段和的
 *  并进行一定的处理求出数组平衡点。
 *
 *  时间复杂度为：O(n)
 *  --------------------------------------------------------    */
@interface BalencePoint : NSObject
- (NSInteger)getBalencePoint:(NSArray *)A;
- (void) balences:(NSArray *)A;

@end

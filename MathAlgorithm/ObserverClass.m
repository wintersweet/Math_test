//
//  ObserverClass.m
//  MathAlgorithm
//
//  Created by Leo on 2020/4/17.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import "ObserverClass.h"

@implementation ObserverClass

-(NSMutableArray*)dataArray
{
  if (!_dataArray) {
    _dataArray = [NSMutableArray array];
  }
  return _dataArray;
}
@end

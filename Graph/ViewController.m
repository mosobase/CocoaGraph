//
//  ViewController.m
//  Graph
//
//  Created by Marcus Osobase on 2016-06-17.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import "ViewController.h"
#import "GraphView.h"
#import "Network.h"
#import "GraphScrollView.h"

@interface ViewController()

@property (nonatomic) IBOutlet GraphView *graphView;
@property (nonatomic) IBOutlet GraphScrollView *graphScrollView;

@property (nonatomic) int limit;

@end


@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.limit = 0;
  
  self.graphView.dataSpacing = 30;
  
  
  
//  self.graphView.lineStyle = LineStyleStraight;
  
  self.graphView.data = [self generateRandomDataWithNumberOfItems:100
                                                         maxValue:250];
  
  
//  [self.graphView draw];
  
//
//  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//    NSMutableArray *update = [NSMutableArray arrayWithArray:self.graphView.data];
//    [update addObjectsFromArray:[self generateRandomDataWithNumberOfItems:10 maxValue:250]];
//    
//    self.graphView.data = update;
//    
//  });
  
//  [self populateWithNetworkActivity];
  
}


- (void)viewWillAppear
{
  [super viewWillAppear];
  
  [self.graphView draw];
  
}

- (void)populateWithNetworkActivity
{
  if (self.limit == 30) return;
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    
    NSDictionary *vals = [Network.instance usage];
    float newVal = [[vals objectForKey:@"WiFiReceived"] floatValue];
    
    if (newVal > 500) newVal = 500;
   
    NSMutableArray *update = [NSMutableArray arrayWithArray:self.graphView.data];
    [update addObject:[NSNumber numberWithFloat:newVal]];
    
    self.graphView.data = update;
    
    self.limit ++;
    
    [self populateWithNetworkActivity];
    
  });
}

- (void)setRepresentedObject:(id)representedObject {
  [super setRepresentedObject:representedObject];
  
  // Update the view, if already loaded.
}


- (NSArray *)generateRandomDataWithNumberOfItems: (int)numberOfItems
                                        maxValue: (int)maxValue
{
  NSMutableArray *data = [NSMutableArray new];
  
  for (int i = 0; i < numberOfItems; i++)
  {
    int value = (arc4random() % maxValue);
    [data insertObject:@(value) atIndex:i];
  }
  
  return data;
  
}

@end

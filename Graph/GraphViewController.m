//
//  GraphViewController.m
//  Graph
//
//  Created by Marcus Osobase on 2016-06-17.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import "GraphViewController.h"
#import "GraphView.h"
#import "Network.h"
#import "GraphScrollView.h"
#import "GraphScaleView.h"
#import "NSColor+Theme.h"
#import <QuartzCore/QuartzCore.h>

@interface GraphViewController()

@property (nonatomic) IBOutlet GraphView *graphView;
@property (nonatomic) IBOutlet GraphScrollView *graphScrollView;

@end


@implementation GraphViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.graphView.strokeGradientColors =
  @[(__bridge id)NSColorFromRGB(0x6fbb3d).CGColor,
    (__bridge id)NSColorFromRGB(0x01b0bd).CGColor];
    
  self.graphView.data = [self generateRandomDataWithNumberOfItems:300
                                                         maxValue:100];
  
//  self.graphView.graphDataInputType = GraphDataInputRolling;
//  [self populateWithNetworkActivity];
}

-(void)viewDidAppear
{
  [self.graphView.layer setNeedsDisplay];
}

- (void)awakeFromNib
{
  [self setupScaleView];
  
}

- (void)setupScaleView
{
  [self.graphView.scaleView removeFromSuperview];
  
  self.graphView.scaleView = [[GraphScaleView alloc]
                              initWithFrame:self.graphView.frame];
  
  
//  NSView *test = [[NSView alloc] initWithFrame:NSMakeRect(50, 50, 50, 50)];
//  [test setWantsLayer:YES];
//  test.layer.backgroundColor = [NSColor redColor].CGColor;
//  
//  [self.view addSubview:test
//             positioned:NSWindowBelow relativeTo:self.graphView];
  
//  self.graphView.scaleView.constraints = self.graphView.constraints;
  
  [self.view addSubview:self.graphView.scaleView
                        positioned:NSWindowBelow relativeTo:self.graphView];
  
  
}


- (void)viewWillAppear
{
  [super viewWillAppear];
  [self.graphView.layer setNeedsDisplay];
}

- (void)populateWithNetworkActivity
{
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    
    NSDictionary *vals = [Network.instance usage];
    float newVal = [[vals objectForKey:@"WiFiReceived"] floatValue];
   
    NSMutableArray *update = [NSMutableArray arrayWithArray:self.graphView.data];
    [update addObject:[NSNumber numberWithFloat:newVal]];
    
    self.graphView.data = update;
    
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
    
//    if (value == 2)
//    {
//     value *= 20;
//      NSLog(@"%d", value);
//    }
    
    [data insertObject:@(value) atIndex:i];
  }
  
//  NSLog(@"%@", data);
  
  return [data copy];
  
}

@end

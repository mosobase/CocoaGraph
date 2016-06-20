//
//  Network.m
//  GraphView
//
//  Created by Marcus Osobase on 2016-06-17.
//
//

#define Megabit 0.000008

#import "Network.h"
#import "Foundation/Foundation.h"


#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>

#include "ntstat.h"


static NSString *const DataCounterKeyWWANSent = @"WWANSent";
static NSString *const DataCounterKeyWWANReceived = @"WWANReceived";
static NSString *const DataCounterKeyWiFiSent = @"WiFiSent";
static NSString *const DataCounterKeyWiFiReceived = @"WiFiReceived";

@interface Network()
@property (nonatomic) double previousWiFiReceived;
@end


@implementation Network

+ (instancetype)instance
{
  static Network *instance = nil;
  static dispatch_once_t pred;
  
  dispatch_once(&pred, ^{
    instance = [Network new];
  });
  
  return instance;
}


-(NSDictionary *)usage
{
  struct ifaddrs *addrs;
  const struct ifaddrs *cursor;
  
  u_int32_t WiFiSent = 0;
  u_int32_t WiFiReceived = 0;
  u_int32_t WWANSent = 0;
  u_int32_t WWANReceived = 0;
  
  if (getifaddrs(&addrs) == 0)
  {
    cursor = addrs;
    while (cursor != NULL)
    {
      if (cursor->ifa_addr->sa_family == AF_LINK)
      {
        //#ifdef DEBUG
        //        const struct if_data *ifa_data = (struct if_data *)cursor->ifa_data;
        //        if(ifa_data != NULL)
        //        {
        //          if (strcmp(cursor->ifa_name, "en0") == 0) {
        ////            double bits = (double)(ifa_data->ifi_obytes)*0.000001;
        //
        ////              NSLog(@"Interface name %s: sent %f received %tu",cursor->ifa_name,bits,ifa_data->ifi_ibytes);
        //          }
        //
        //        }
        //#endif
        
        // name of interfaces:
        // en0 is WiFi
        // pdp_ip0 is WWAN
        NSString *name = [NSString stringWithFormat:@"%s",cursor->ifa_name];
        if ([name hasPrefix:@"en"])
        {
          const struct if_data *ifa_data = (struct if_data *)cursor->ifa_data;
          if(ifa_data != NULL)
          {
            WiFiSent += ifa_data->ifi_obytes;
            WiFiReceived += ifa_data->ifi_ibytes;
          }
        }
        
        if ([name hasPrefix:@"pdp_ip"])
        {
          const struct if_data *ifa_data = (struct if_data *)cursor->ifa_data;
          if(ifa_data != NULL)
          {
            WWANSent += ifa_data->ifi_obytes;
            WWANReceived += ifa_data->ifi_ibytes;
          }
        }
      }
      
      cursor = cursor->ifa_next;
    }
    
    freeifaddrs(addrs);
  }

  
  double currentWifiDelta = WiFiReceived - self.previousWiFiReceived;
  if (!self.previousWiFiReceived) currentWifiDelta = 0;
  self.previousWiFiReceived = WiFiReceived;
  
  //LowPass
//  double α = 0.1;
//  double newVal = (currentWifiDelta * α * 10) + (self.previousWiFiDelta * (1.0 - α));
  
  
  NSLog(@"%f", currentWifiDelta * Megabit);
  
  NSDictionary *result =
  @{DataCounterKeyWiFiSent:[NSNumber numberWithUnsignedInt:WiFiSent],
    DataCounterKeyWiFiReceived: [NSNumber numberWithFloat:currentWifiDelta * Megabit],
    DataCounterKeyWWANSent:[NSNumber numberWithUnsignedInt:WWANSent],
    DataCounterKeyWWANReceived:[NSNumber numberWithUnsignedInt:WWANReceived]};
  
  
  
  
//  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//     [self usage];
//  });
//  
  
  
  return result;
  
}



@end

//
//  NSColor+Theme.m
//  TunnelBear
//
//  Created by Marcus Osobase on 2016-01-05.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import "NSColor+Theme.h"

@implementation NSColor (Theme)

+ (NSColor *)defaultTextColor
{
  return NSColorFromRGB(0x715942);
}

+ (NSColor *)popupTextColor
{
  return NSColorFromRGB(0x645b45);
}

+ (NSColor *)brownTintColor
{
  return NSColorFromRGB(0xc4932a);
}

+ (NSColor *)alertTintColor
{
  return NSColorFromRGB(0xde3f4e);
}

+ (NSColor *)defaultTintColor
{
  return NSColorFromRGB(0x391816);
}

+ (NSColor *)upgradeTintColor
{
  return NSColorFromRGB(0xd7a53b);
}

+ (NSColor*)buttonBorderColor
{
  return NSColorFromRGB(0xdfdfdf);
}

+ (NSColor*)buttonFontColor
{
  return NSColorFromRGB(0x008b89);
}
+ (NSColor*)buttonBackgroundColor
{
  return NSColorFromRGB(0x55534f);
}
+ (NSColor*)buttonBackgroundInactiveColor
{
  return [NSColor colorWithRed:0 green:0 blue:0 alpha:0.05];
}

+ (NSColor *)textFieldTextColor
{
  return NSColorFromRGB(0x7c5543);
}

+ (NSColor *)textFieldPlaceholderTextColor
{
  return [NSColorFromRGB(0x997a6d) colorWithAlphaComponent:0.6];
}










+ (NSColor *)intColorWithRed: (NSUInteger)red
                       green: (NSUInteger)green
                        blue: (NSUInteger)blue
                       alpha: (CGFloat)alpha
{
  return [NSColor colorWithSRGBRed: red/255.0
                             green: green/255.0
                              blue: blue/255.0
                             alpha: alpha];
}

+ (NSColor *)dialTextOnOnColor
{
  return [NSColor colorWithHexString: @"ECD397"];
}

+ (NSColor *)dialTextOnOffColor
{
  return [NSColor colorWithHexString: @"CAB278"];
}

+ (NSColor *)dialTextOffOnColor
{
  return [NSColor colorWithHexString: @"E1C88D"];
}

+ (NSColor *)dialTextOffOffColor
{
  return [NSColor colorWithHexString: @"CAB278"];
}

+ (NSColor *)dialTextShadowColor
{
  return [NSColor colorWithHexString: @"420800"
                               alpha: 0.7];
}

+ (NSColor *)popupBackgroundColor
{
  return [NSColor colorWithHexString: @"ecddc7"];
}

+ (NSColor *)popupHoverBackgroundColor
{
  return [NSColor colorWithHexString: @"e3d0b9"];
}

+ (NSColor *)displayConnectedStatusColor
{
  return [NSColor colorWithHexString: @"85d9f4"];
}

+ (NSColor *)displayDisconnectedStatusColor
{
  return [NSColor colorWithHexString: @"353834"];
}

+ (NSColor *)progressBarConnectedBackgroundColor
{
  return [NSColor colorWithHexString: @"59AFCF"];
}

+ (NSColor *)progressBarDisconnectedBackgroundColor
{
  return [NSColor colorWithHexString: @"4E504E"];
}

+ (NSColor *)progressBarConnectedColor
{
  return [NSColor colorWithHexString: @"71C5E0"];
}

+ (NSColor *)progressBarDisconnectedColor
{
  return [NSColor colorWithHexString: @"434543"];
}

+ (NSColor *)progressBarConnectedTextColor
{
  return [NSColor colorWithHexString: @"1B6B92"];
}

+ (NSColor *)progressBarDisconnectedTextColor
{
  return [NSColor colorWithHexString: @"747674"];
}

+ (NSColor *)countryDropdownButtonTitleColor
{
  return [NSColor colorWithHexString: @"cba870"];
}

+ (NSColor *)countryDropdownButtonTitleShadowColor
{
  return [NSColor colorWithHexString: @"140001" alpha: 0.5];
}

+ (NSColor *)countryDropdownItemTitleColor
{
  return [NSColor colorWithHexString: @"7c5543"];
}

+ (NSColor *)countryDropdownItemTitleShadowColor
{
  return [NSColor intColorWithRed: 255
                            green: 255
                             blue: 255
                            alpha: 0.3];
}

+ (NSColor *)titleColor
{
  return [NSColor colorWithHexString: @"ffecc2"];
}

+ (NSColor *)titleShadowColor
{
  return [NSColor colorWithHexString: @"622a00"];
}

+ (NSColor *)fieldLabelColor
{
  return [NSColor colorWithHexString: @"7c5543"];
}

+ (NSColor *)lightShadowColor
{
  return [NSColor intColorWithRed: 255 green: 255 blue: 255 alpha: 0.4];
}

+ (NSColor *)errorLabelColor
{
  return [NSColor colorWithHexString: @"dc3333"];
}

+ (NSColor *)dropDownSeparatorColorDark
{
  return [NSColor colorWithHexString: @"d7c6b0"];
}

+ (NSColor *)dropDownSeparatorColorLight
{
  return [NSColor colorWithHexString: @"ebdccc"];
}

+ (NSColor *)dropDownBorderColor
{
  return [NSColor colorWithHexString: @"492318"];
}

+ (NSColor *)yellowButtonLabelColor
{
  return [NSColor colorWithHexString: @"661d00"];
}

+ (NSColor *)linkButtonColor
{
  return [NSColor colorWithHexString: @"997a6d"];
}

+ (NSColor *)orangeLinkButtonColor
{
  return [NSColor colorWithHexString: @"f17023"];
}

+ (NSColor *)textFieldBorderColor
{
  return [NSColor colorWithHexString: @"ccbba7"];
}

+ (NSColor *)textFieldShadowColor
{
  return [NSColor colorWithCalibratedWhite: 0.0f
                                     alpha: 0.35f];
}

+ (NSColor *)textFieldFocusRingColor
{
  return [NSColor colorWithHexString: @"ae978d"];
}

+ (NSColor *)textFieldErrorRingColor
{
  return [NSColor colorWithHexString: @"dc3333"];
}


+ (NSColor *)tweetLabelColor
{
  return [NSColor colorWithHexString: @"d8c196"];
}

+ (NSColor *)tweetLabelShadowColor
{
  return [NSColor colorWithHexString: @"000000" alpha: 0.5];
}

+ (NSColor *)privacyHeaderBackgroundColor
{
  return [NSColor colorWithHexString: @"ecddc7"];
}

+ (NSColor *)privacyHeaderHighlightColor
{
  return [NSColor colorWithHexString: @"d54f57"];
}

+ (NSColor *)privacyHeaderTopShadowColor
{
  return [NSColor colorWithCalibratedWhite: 0
                                     alpha: 0.90];
  
}

+ (NSColor *)privacyHeaderMiddleShadowColor
{
  return [NSColor colorWithCalibratedWhite: 0
                                     alpha: 0.3];
}

+ (NSColor *)privacyHeaderBottomShadowColor
{
  return [NSColor colorWithCalibratedWhite: 0
                                     alpha: 0.15];
}

+ (NSColor *)privacyHeaderTopSeparatorColor
{
  return [NSColor colorWithCalibratedWhite: 0
                                     alpha: 0.15];
}

+ (NSColor *)privacyHeaderMiddleSeparatorColor
{
  return [NSColor colorWithCalibratedWhite: 0
                                     alpha: 0.075];
}

+ (NSColor *)privacyHeaderBottomSeparatorColor
{
  return [NSColor colorWithCalibratedWhite: 0
                                     alpha: 0.03];
}

+ (NSColor *)privacyHeaderStatusLabelOffColor
{
  return [NSColor colorWithHexString: @"eeddc7"];
}

+ (NSColor *)privacyHeaderStatusLabelOnColor
{
  return [NSColor colorWithHexString: @"997a6d"];
}

+ (NSColor *)privacyHeaderTunnelBearIsOffLabelColor
{
  return [NSColor colorWithHexString: @"cbb9a2"];
}

+ (NSColor *)privacyBackgroundColor
{
  return [NSColor colorWithHexString: @"E4D0B7"];
}


+ (NSColor *)privacySeparatorLightColor
{
  return [NSColor colorWithHexString: @"ebdccc"];
}

+ (NSColor *)privacySeparatorDarkColor
{
  return [NSColor colorWithHexString: @"d7c6b0"];
}

+ (NSColor *)privacyIntelliBackgroundColor
{
  return [NSColor colorWithHexString: @"e4d2b9"];
}

+ (NSColor *)privacyHeaderOnOffButtonOnColor
{
  return [NSColor colorWithHexString: @"b77e3c"];
}

+ (NSColor *)privacyHeaderOnOffButtonOffColor
{
  return [NSColor colorWithHexString: @"d7c6b0"];
}

+ (NSColor *)privacyHeaderOnOffButtonHighlightColor
{
  return [NSColor colorWithCalibratedRed: 0.73
                                   green: 0.66
                                    blue: 0.60
                                   alpha:1.00f];
}

+ (NSColor *)privacyButtonTextColor
{
  return [NSColor colorWithHexString: @"c4a16a"];
}

+ (NSColor *)privacyButtonShadowColor
{
  return [NSColor colorWithHexString: @"140001" alpha: 0.5];
}
+(NSColor *)preferenceButtonColor
{
  return [NSColor colorWithHexString: @"f2e1b9" alpha: 1];
}
+(NSColor *)preferenceBackgroundColor
{
  return [NSColor colorWithHexString:@"ecdcc7"];
}
+(NSColor *)preferenceTableBackgroundColor
{
  return [NSColor colorWithHexString:@"e4d1ba"];
}
+(NSColor *)preferenceTableBorderColor
{
  return [NSColor colorWithHexString:@"cdbca7"];
}
+(NSColor *)preferenceTableHighlightColor
{
  return [NSColor colorWithHexString:@"d6c3ac"];
}
+ (NSColor *)preferenceTextColor
{
  return [NSColor colorWithHexString:@"c09f91"];
}
+ (NSColor *)progressBarIntelliConnectedBackgroundColor
{
  return [NSColor colorWithHexString: @"ffcc70"];
}
+ (NSColor *)progressBarIntelliConnectedTextColor
{
  return [NSColor colorWithHexString: @"a86a19"];
}
+ (NSColor *)displayConnectedStatusIntelliColor
{
  return [NSColor colorWithHexString: @"f9e88b"];
}

+ (NSColor *)diagProgressBarBackgroundColor
{
  return [NSColor colorWithHexString: @"#E5D1B9"];
}

+ (NSColor *)diagProgressBarForegroundColor1
{
  return [NSColor colorWithHexString: @"#EB5F0E"];
}

+ (NSColor *)diagProgressBarForegroundColor2
{
  return [NSColor colorWithHexString: @"#EF730F"];
}

+ (NSColor *)diagProgressBarOutsideBorderColor
{
  return [NSColor colorWithHexString: @"#C2B09A"];
}

+ (NSColor *)diagProgressBarInsideBorderColor
{
  return [NSColor colorWithHexString: @"#D7C6AE"];
}

+ (NSColor *)diagResultsViewBackgroundColor
{
  return [NSColor colorWithHexString: @"e5d1b9"];
}

+ (NSColor *)diagResultsViewBorderColor
{
  return [NSColor colorWithHexString: @"d7c6ae"];
}

+ (NSColor *)diagResultsViewTopBorderColor
{
  return [NSColor colorWithHexString: @"c2b09a"];
}


//------------------------------------------------------------------------
#pragma mark - Private Methods

//
// taken from http://stackoverflow.com/questions/1560081/how-can-i-create-a-uicolor-from-a-hex-string
//

+ (NSColor *)colorWithHexString: (NSString *)hexString
                          alpha: (CGFloat)alpha
{
  NSString *alphaHex =
  [NSString stringWithFormat: @"%x", (unsigned int)(255 * alpha)];
  return [self colorWithHexString:
          [alphaHex stringByAppendingString: hexString]];
}

+ (NSColor *)colorWithHexString: (NSString *)hexString
{
  NSString *colorString =
  [[hexString stringByReplacingOccurrencesOfString: @"#"
                                        withString: @""] uppercaseString];
  CGFloat alpha, red, blue, green;
  switch (colorString.length)
  {
    case 3: // #RGB
    {
      alpha = 1.0f;
      red   = [self colorComponentFrom: colorString start: 0 length: 1];
      green = [self colorComponentFrom: colorString start: 1 length: 1];
      blue  = [self colorComponentFrom: colorString start: 2 length: 1];
      break;
    }
    case 4: // #ARGB
    {
      alpha = [self colorComponentFrom: colorString start: 0 length: 1];
      red   = [self colorComponentFrom: colorString start: 1 length: 1];
      green = [self colorComponentFrom: colorString start: 2 length: 1];
      blue  = [self colorComponentFrom: colorString start: 3 length: 1];
      break;
    }
    case 6: // #RRGGBB
    {
      alpha = 1.0f;
      red   = [self colorComponentFrom: colorString start: 0 length: 2];
      green = [self colorComponentFrom: colorString start: 2 length: 2];
      blue  = [self colorComponentFrom: colorString start: 4 length: 2];
      break;
    }
    case 8: // #AARRGGBB
    {
      alpha = [self colorComponentFrom: colorString start: 0 length: 2];
      red   = [self colorComponentFrom: colorString start: 2 length: 2];
      green = [self colorComponentFrom: colorString start: 4 length: 2];
      blue  = [self colorComponentFrom: colorString start: 6 length: 2];
      break;
    }
    default:
    {
      [NSException raise: @"Invalid color value"
                  format: @"Color value %@ is invalid.  "
       "It should be a hex value of the form "
       "#RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
      break;
    }
  }
  return [NSColor colorWithSRGBRed: red
                             green: green
                              blue: blue
                             alpha: alpha];
}

+ (CGFloat)colorComponentFrom: (NSString *)string
                        start: (NSUInteger)start
                       length: (NSUInteger) length
{
  NSString *substring =
  [string substringWithRange: NSMakeRange(start, length)];
  NSString *fullHex =
  length == 2 ?
  substring :
  [NSString stringWithFormat: @"%@%@", substring, substring];
  
  unsigned hexComponent;
  [[NSScanner scannerWithString: fullHex]
   scanHexInt: &hexComponent];
  return hexComponent / 255.0;
}
@end

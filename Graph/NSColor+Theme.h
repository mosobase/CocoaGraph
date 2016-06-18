//
//  NSColor+Theme.h
//  TunnelBear
//
//  Created by Marcus Osobase on 2016-01-05.
//  Copyright © 2016 TunnelBear. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define RGBA(r,g,b,a) [NSColor colorWithCalibratedRed:r/255.f green:g/255.f blue:b/255.f alpha:a/255.f]

#define NSColorFromRGB(rgbValue) [NSColor colorWithCalibratedRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface NSColor (Theme)

+ (NSColor *)defaultTextColor;
+ (NSColor *)brownTintColor;
+ (NSColor *)popupTextColor;
+ (NSColor *)alertTintColor;
+ (NSColor *)defaultTintColor;
+ (NSColor *)upgradeTintColor;

+ (NSColor*)buttonBorderColor;
+ (NSColor*)buttonFontColor;
+ (NSColor*)buttonBackgroundColor;
+ (NSColor*)buttonBackgroundInactiveColor;
+ (NSColor *)textFieldTextColor;
+ (NSColor *)textFieldPlaceholderTextColor;






+ (NSColor *)intColorWithRed: (NSUInteger)red
                       green: (NSUInteger)green
                        blue: (NSUInteger)blue
                       alpha: (CGFloat)alpha;

+ (NSColor *)dialTextOnOnColor;
+ (NSColor *)dialTextOnOffColor;
+ (NSColor *)dialTextOffOnColor;
+ (NSColor *)dialTextOffOffColor;
+ (NSColor *)dialTextShadowColor;

+ (NSColor *)popupBackgroundColor;
+ (NSColor *)popupHoverBackgroundColor;

+ (NSColor *)displayConnectedStatusColor;
+ (NSColor *)displayDisconnectedStatusColor;

+ (NSColor *)progressBarConnectedBackgroundColor;
+ (NSColor *)progressBarDisconnectedBackgroundColor;
+ (NSColor *)progressBarConnectedColor;
+ (NSColor *)progressBarDisconnectedColor;
+ (NSColor *)progressBarConnectedTextColor;
+ (NSColor *)progressBarDisconnectedTextColor;

+ (NSColor *)countryDropdownButtonTitleColor;
+ (NSColor *)countryDropdownButtonTitleShadowColor;
+ (NSColor *)countryDropdownItemTitleColor;
+ (NSColor *)countryDropdownItemTitleShadowColor;

+ (NSColor *)dropDownSeparatorColorDark;
+ (NSColor *)dropDownSeparatorColorLight;
+ (NSColor *)dropDownBorderColor;


+ (NSColor *)titleColor;
+ (NSColor *)titleShadowColor;
+ (NSColor *)fieldLabelColor;

+ (NSColor *)lightShadowColor;
+ (NSColor *)errorLabelColor;
+ (NSColor *)linkButtonColor;
+ (NSColor *)orangeLinkButtonColor;

+ (NSColor *)yellowButtonLabelColor;


+ (NSColor *)textFieldBorderColor;
+ (NSColor *)textFieldShadowColor;
+ (NSColor *)textFieldFocusRingColor;
+ (NSColor *)textFieldErrorRingColor;

+ (NSColor *)tweetLabelColor;
+ (NSColor *)tweetLabelShadowColor;

+ (NSColor *)privacyHeaderBackgroundColor;
+ (NSColor *)privacyHeaderHighlightColor;
+ (NSColor *)privacyHeaderTopShadowColor;
+ (NSColor *)privacyHeaderMiddleShadowColor;
+ (NSColor *)privacyHeaderBottomShadowColor;
+ (NSColor *)privacyHeaderTopSeparatorColor;
+ (NSColor *)privacyHeaderMiddleSeparatorColor;
+ (NSColor *)privacyHeaderBottomSeparatorColor;
+ (NSColor *)privacyHeaderStatusLabelOffColor;
+ (NSColor *)privacyHeaderStatusLabelOnColor;
+ (NSColor *)privacyHeaderTunnelBearIsOffLabelColor;
+ (NSColor *)privacyHeaderOnOffButtonOnColor;
+ (NSColor *)privacyHeaderOnOffButtonOffColor;
+ (NSColor *)privacyHeaderOnOffButtonHighlightColor;


+ (NSColor *)privacyBackgroundColor;
+ (NSColor *)privacySeparatorLightColor;
+ (NSColor *)privacySeparatorDarkColor;
+ (NSColor *)privacyIntelliBackgroundColor;

+ (NSColor *)privacyButtonTextColor;
+ (NSColor *)privacyButtonShadowColor;

+ (NSColor *)preferenceButtonColor;
+ (NSColor *)preferenceBackgroundColor;
+ (NSColor *)preferenceTableBackgroundColor;
+ (NSColor *)preferenceTableBorderColor;
+ (NSColor *)preferenceTableHighlightColor;
+ (NSColor *)preferenceTextColor;

+ (NSColor *)progressBarIntelliConnectedBackgroundColor;
+ (NSColor *)progressBarIntelliConnectedTextColor;
+ (NSColor *)displayConnectedStatusIntelliColor;


+ (NSColor *)diagProgressBarBackgroundColor;
+ (NSColor *)diagProgressBarForegroundColor1;
+ (NSColor *)diagProgressBarForegroundColor2;
+ (NSColor *)diagProgressBarOutsideBorderColor;
+ (NSColor *)diagProgressBarInsideBorderColor;
+ (NSColor *)diagResultsViewBackgroundColor;
+ (NSColor *)diagResultsViewBorderColor;
+ (NSColor *)diagResultsViewTopBorderColor;

@end

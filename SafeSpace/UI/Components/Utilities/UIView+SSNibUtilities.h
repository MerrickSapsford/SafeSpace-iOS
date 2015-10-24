
#import <UIKit/UIKit.h>

@interface UIView (SSNibUtilities)

- (instancetype)initWithNib:(NSString *)nibName;

- (UIView *)addNibView:(NSString *)nibName;

- (UIView *)addNibView:(NSString *)nibName withCoder:(BOOL)withCoder;

+ (UIView *)viewFromNib:(NSString *)nibName;

+ (BOOL)nib:(NSString *)nibName existsInBunde:(NSBundle *)bundle;

@end

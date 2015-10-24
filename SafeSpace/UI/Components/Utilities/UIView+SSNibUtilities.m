
#import "UIView+SSNibUtilities.h"
#import "UIView+SSAutoLayout.h"
#import <objc/runtime.h>

NSString *const kTabletSuffix = @"-ipad";

@implementation UIView (SSNibUtilities)

+ (BOOL)nib:(NSString *)nibName existsInBunde:(NSBundle *)bundle {
    return ([bundle pathForResource:nibName ofType:@"nib"] != nil);
}

- (instancetype)initWithNib:(NSString *)nibName {
    return [UIView viewFromNib:nibName];
}

- (UIView *)addNibView:(NSString *)nibName {
    return [self addNibView:nibName withCoder:YES];
}

- (UIView *)addNibView:(NSString *)nibName withCoder:(BOOL)withCoder {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    if([UIView nib:nibName existsInBunde:bundle]) {
        NSArray *nibContents = [bundle loadNibNamed:nibName owner:self options:nil];
        UIView *view = nibContents[0];
        [self addSubview:view];
        
        if (withCoder) {
            self.translatesAutoresizingMaskIntoConstraints = NO;
        }
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addExpandingSubview:view];
        
        return view;
    }
    
    return nil;
}

+ (UIView *)viewFromNib:(NSString *)nibName {
    UINib *nib = [self cachedNibWithName:nibName];
    if (nib) {
        return [nib instantiateWithOwner:self options:nil][0];
    }
    return nil;
}

+ (UINib *)cachedNibWithName:(NSString *)nibName {
    static char kUIViewNibUtilitiesCachedNibsKey;
    
    NSDictionary *cachedNibs = objc_getAssociatedObject(self, &kUIViewNibUtilitiesCachedNibsKey);
    UINib *nib = cachedNibs[nibName];
    
    if (!nib) {
        nib = [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]];
        if (nib) {
            NSMutableDictionary *loadedNibs = [NSMutableDictionary dictionaryWithDictionary:cachedNibs];
            loadedNibs[nibName] = nib;
            objc_setAssociatedObject(self, &kUIViewNibUtilitiesCachedNibsKey, [NSDictionary dictionaryWithDictionary:loadedNibs], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    return nib;
}

@end


#import <UIKit/UIKit.h>

@interface UIView (SSAutoLayout)

+ (UIView *)viewWithStackedSubviews:(NSArray *)subviews;

/*
 * Add a subview to the current view which expands with the view bounds
 *
 * @param subview - the subview to add
 */
- (void)addExpandingSubview:(UIView *)subview;

/*
 * Add a subview to the current view which expands with the view bounds
 *
 * @param subview - the subview to add
 * @param insets - insets to the bounds of the subview
 */
- (void)addExpandingSubview:(UIView *)subview edgeInsets:(UIEdgeInsets)insets;

/*
 * Add an oversized subview to the current view which expands with the view bounds
 *
 * @param subview - the subview to add
 */
- (void)addTabletOversizedExpandingSubview:(UIView *)subview;

/*
 * Add a subview to the current view which remains pinned to the top and sides of the view
 *
 * @param subview - the subview to add
 */
- (void)addPinnedToTopAndSidesSubview:(UIView *)subview;

/*
 * Add a subview to the current view which remains pinned to the top and sides of the view
 *
 * @param subview - the subview to add
 * @param height - the height of the subview
 */
- (void)addPinnedToTopAndSidesSubview:(UIView *)subview height:(CGFloat)height;

/*
 * Add a subview to the current view which remains pinned to the top and sides of the view
 *
 * @param subview - the subview to add
 * @param height - the height of the subview
 * @param topInset - the top inset for the subview
 */
- (void)addPinnedToTopAndSidesSubview:(UIView *)subview height:(CGFloat)height topInset:(CGFloat)topInset;

/*
 * Add a horizontally oversized subview to the current view which remains pinned to the top and sides of the view
 *
 * @param subview - the subview to add
 */
- (void)addTabletOversizedPinnedToTopAndSidesSubview:(UIView *)subview;

/*
 * Add a specified width constraint to a view
 *
 * @param width - the desired width of the view
 * @param view - the view to apply the constraint to
 */
- (NSLayoutConstraint *)addWidthConstraint:(CGFloat)width toView:(UIView*)view;

/*
 * Add a specified height constraint to a view
 *
 * @param height - the desired height of the view
 * @param view - the view to apply the constraint to
 */
- (NSLayoutConstraint *)addHeightConstraint:(CGFloat)height toView:(UIView*)view;

/*
 * Add an array of subviews that are stacked vertically beneath each other
 *
 * @param subviews - the subviews to add
 */
- (void)insertStackedSubviews:(NSArray *)subviews;

- (NSLayoutConstraint *)pinSubviewToLeft:(UIView *)subview padding:(CGFloat)padding;

- (NSLayoutConstraint *)pinSubviewToRight:(UIView *)subview padding:(CGFloat)padding;

- (NSLayoutConstraint *)pinSubviewToBottom:(UIView *)subview padding:(CGFloat)padding;

- (NSLayoutConstraint *)pinSubviewToTop:(UIView *)subview padding:(CGFloat)padding;

@end

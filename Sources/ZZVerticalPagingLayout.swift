//
//  ZZVerticalPagingLayout.swift
//

import UIKit

public class ZZVerticalPagingLayout: UICollectionViewFlowLayout {
    
    public var zoomRatio: CGFloat = 0.0
    
    public override func prepare() {
        super.prepare()
        minimumInteritemSpacing = 0
        scrollDirection = .vertical
        
        guard let collectionView = collectionView else { return }
        let itemInset = collectionView.frame.size.height - itemSize.height
        
        if collectionView.responds(to: NSSelectorFromString("_setInterpageSpacing:")) == true {
            let selector = NSSelectorFromString("_setInterpageSpacing:")
            if let method = class_getInstanceMethod(type(of: collectionView), selector) {
                typealias MyFunction = @convention(c) (AnyObject, Selector, CGSize) -> Void
                let function = unsafeBitCast(method_getImplementation(method), to: MyFunction.self)
                let size = CGSize(width: 0, height: -(itemInset - minimumLineSpacing))
                function(collectionView, selector, size)
            }
        }
        
        if collectionView.responds(to: NSSelectorFromString("_setPagingOrigin:")) == true {
            let selector = NSSelectorFromString("_setPagingOrigin:")
            if let method = class_getInstanceMethod(type(of: collectionView), selector) {
                typealias MyFunction = @convention(c) (AnyObject, Selector, CGPoint) -> Void
                let function = unsafeBitCast(method_getImplementation(method), to: MyFunction.self)
                function(collectionView, selector, CGPoint(x: 0, y: 0))
            }
        }
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView,
              let attributesArray = super.layoutAttributesForElements(in: rect) else { return [] }
        let visibleRect = CGRect(x: collectionView.contentOffset.x, y: collectionView.contentOffset.y, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        for attributes in attributesArray {
            let distance = (visibleRect.origin.y + visibleRect.size.height / 2.0) - attributes.center.y
            let normalizedDistance = abs(distance / itemSize.height)
            let zoom = 1 - zoomRatio * normalizedDistance
            attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0)
        }
        return attributesArray
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

//
//  MIPageControl.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//


import UIKit

final class MIPageControl: UIControl {
  //MARK:- Properties
    
       /// The number of page indicators to display.
    public var numberOfPages: Int = 3 {
           didSet {
               removeViews()
               setupViews()
           }
       }
       
       /// The current page, displayed as a filled circle.
    public var currentPage: Int = 0 {
           didSet {
               UIView.animate(withDuration: 0.1) { [weak self] in
                   guard let strongSelf = self, strongSelf.pageIndicators.count > strongSelf.currentPage else {
                       return
                   }
                   let newCenter = strongSelf.pageIndicators[strongSelf.currentPage].center
                   strongSelf.currentPageIndicator.center = newCenter
               }
           }
       }
       
       /// The spacing between page indicators.
    public var spacing: CGFloat = 10 {
           didSet {
               NSLayoutConstraint.deactivate(horizontalConstraints)
               setupHorizontalConstraints()
           }
       }
       
       /// Diameter of page indicator.
    public var indicatorDiameter: CGFloat = 6.0 {
           didSet {
               NSLayoutConstraint.deactivate(sizeConstraints)
               pageIndicators.forEach { $0.layer.cornerRadius = indicatorDiameter / 2.0 }
               setupSizeConstraints()
           }
       }
       
       /// Diameter of current page indicator.
    public var currentIndicatorDiameter: CGFloat = 6 {
           didSet {
               NSLayoutConstraint.deactivate(sizeConstraints)
               currentPageIndicator.layer.cornerRadius = currentIndicatorDiameter / 2
            currentPageIndicator.layer.masksToBounds = true
               setupSizeConstraints()
           }
       }
       
       /// Color of page indicator.
    public var indicatorTintColor: UIColor = .gray {
           didSet {
               pageIndicators.forEach { $0.backgroundColor = indicatorTintColor }
           }
       }
       
       /// Color of current page indicator.
    public var currentIndicatorTintColor: UIColor = UIColor(color: .appPrimary)! {
           didSet {
               currentPageIndicator.backgroundColor = currentIndicatorTintColor
           }
       }
       
       /// Used to size control to fit a certian number of pages.
       /// - Parameter pagesNumber: A number of pages to calculate size for.
       /// - Returns: Minimum size required to fit pageControl with certian number of pages.
    public func size(forNumberOfPages numberOfPages: Int) -> CGSize {
           guard numberOfPages > 0 else { return .zero }
           let maxDiameter = max(indicatorDiameter, currentIndicatorDiameter)
           let diametersDifference = maxDiameter - min(indicatorDiameter, currentIndicatorDiameter)
           let width = CGFloat(numberOfPages - 1) * spacing + CGFloat(numberOfPages) * indicatorDiameter + diametersDifference
           return CGSize(width: width, height: maxDiameter)
       }
       
    override public func awakeFromNib() {
           super.awakeFromNib()
           setupViews()
       }
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupViews()
       }
       
       required public init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
       
       //MARK: private methods
       
       private lazy var currentPageIndicator: UIView = {
           return self.currentPageIndicator(with: self.currentIndicatorDiameter, backgroundColor: self.currentIndicatorTintColor)
       }()
       private var pageIndicators: [UIView] = []
       
       private var sizeConstraints: [NSLayoutConstraint] = []
       private var horizontalConstraints: [NSLayoutConstraint] = []
       
       private func pageIndicator(with diameter: CGFloat, backgroundColor: UIColor?) -> UIView {
           let view = UIView(frame: .zero)
           view.clipsToBounds = true
           view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = backgroundColor
           view.layer.cornerRadius = diameter / 2.0
           return view
       }
    private func currentPageIndicator(with diameter: CGFloat, backgroundColor: UIColor?) -> UIView {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
        
        view.layer.cornerRadius = diameter / 2
        return view
    }
       private func removeViews() {
           for view in subviews {
               pageIndicators = []
               sizeConstraints = []
               horizontalConstraints = []
               NSLayoutConstraint.deactivate(view.constraints)
               view.removeFromSuperview()
           }
       }
       
       private func setupViews() {
           if numberOfPages != 0 {
               for _ in 0..<numberOfPages {
                   pageIndicators.append(pageIndicator(with: indicatorDiameter, backgroundColor: indicatorTintColor))
               }
               
               (pageIndicators + [currentPageIndicator]).forEach { addSubview($0) }
               
               setupLayout()
               
               setCurrrentIndicatorLocation()
           }
       }
       
       private func setCurrrentIndicatorLocation() {
           if numberOfPages != 0 {
               let firstDot = pageIndicators[0]
               currentPageIndicator.center = firstDot.center
           }
       }
       
       // MARK: layout
       
    override public func layoutSubviews() {
           super.layoutSubviews()
           
           guard pageIndicators.count > currentPage else { return }
           let updatedCenter = pageIndicators[currentPage].center
           
           if self.currentPageIndicator.center != updatedCenter {
               self.currentPageIndicator.center = updatedCenter
           }
       }
       
       private func setupLayout() {
           setupSizeConstraints()
           setupHorizontalConstraints()
           
           let verticalConstraints = (pageIndicators + [currentPageIndicator]).map {
               return $0.centerYAnchor.constraint(equalTo: centerYAnchor)
           }
           
           NSLayoutConstraint.activate(verticalConstraints)
       }
       
       private func setupHorizontalConstraints() {
           horizontalConstraints = horizontalConstraintsForIndicators()
           NSLayoutConstraint.activate(horizontalConstraints)
       }
       
       private func setupSizeConstraints () {
           sizeConstraints = sizeConstraintsForIndicators()
           NSLayoutConstraint.activate(sizeConstraints)
       }
       
       private func horizontalConstraintsForIndicators() -> [NSLayoutConstraint] {
           var constraints = [NSLayoutConstraint]()
           
           let isNumberOfIndicatorsEven = Double(pageIndicators.count).truncatingRemainder(dividingBy: 2.0) == 0.0
           let initialElementIndex = isNumberOfIndicatorsEven ? (pageIndicators.count / 2) - 1 : (pageIndicators.count / 2)
           let initialElement = pageIndicators[initialElementIndex]
           
           for index in 0...pageIndicators.count - 1 {
               let view = pageIndicators[index]
               let constraint: NSLayoutConstraint
               
               if (index != initialElementIndex) {
                   let constant = (spacing + indicatorDiameter) * CGFloat(index - initialElementIndex)
                   constraint = view.centerXAnchor.constraint(equalTo: initialElement.centerXAnchor, constant: constant)
               } else {
                   constraint = view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: isNumberOfIndicatorsEven ? -((spacing + indicatorDiameter) / 2.0) : 0.0)
               }
               
               constraints.append(constraint)
           }
           
           return constraints
       }
       
       private func sizeConstraintsForIndicators() -> [NSLayoutConstraint] {
           var constraints = [NSLayoutConstraint]()
           
           constraints.append(contentsOf: constraintsWithHeightAndWidthForCurentIndex(equalTo: currentIndicatorDiameter, for: currentPageIndicator))
           pageIndicators.forEach { view in
               constraints.append(contentsOf: constraintsWithHeightAndWidth(equalTo: indicatorDiameter, for: view))
           }
           
           return constraints
       }
       
       private func constraintsWithHeightAndWidth(equalTo constant: CGFloat, for view: UIView) -> [NSLayoutConstraint] {
           return [
               view.heightAnchor.constraint(equalToConstant: constant),
               view.widthAnchor.constraint(equalTo: view.heightAnchor)
           ]
       }
    private func constraintsWithHeightAndWidthForCurentIndex(equalTo constant: CGFloat, for view: UIView) -> [NSLayoutConstraint] {
        return [
            view.heightAnchor.constraint(equalToConstant: constant),
            view.widthAnchor.constraint(equalTo: view.heightAnchor,multiplier: 2)
        ]
    }
   }

   // MARK: - Self sizing
extension MIPageControl {
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
           if numberOfPages == 0 {
               return .zero
           } else {
               let size = self.size(forNumberOfPages: numberOfPages)
               let width: CGFloat = min(superview?.bounds.width ?? .greatestFiniteMagnitude, size.width)
               return CGSize(width: width, height: size.height)
           }
       }

    public override var intrinsicContentSize: CGSize {
           if numberOfPages == 0 {
               return .zero
           } else {
               return size(forNumberOfPages: numberOfPages)
           }
       }
   }

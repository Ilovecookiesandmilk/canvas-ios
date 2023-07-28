//
// This file is part of Canvas.
// Copyright (C) 2019-present  Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

import Core
import UIKit

@IBDesignable
class AssignmentDetailsSectionContainerView: UIView {
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var header: DynamicLabel!
    @IBOutlet weak var subHeader: DynamicLabel!
    @IBOutlet weak var divider: DividerView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackViewTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var stackViewBottomAnchor: NSLayoutConstraint!

    @IBInspectable var stackViewTopOffset: Double = 0 {
        didSet {
            stackViewTopAnchor.constant = stackViewTopOffset
        }
    }

    @IBInspectable var stackViewBottomOffset: Double = 0 {
        didSet {
            stackViewBottomAnchor.constant = stackViewBottomOffset
        }
    }

    @IBInspectable var headerText: String? {
        didSet {
            header?.text = headerText
        }
    }

    @IBInspectable
    public var headerTextColorName: String = "textDarkest" {
        didSet {
            header.textColor = Brand.shared.color(headerTextColorName) ?? .textDarkest
        }
    }

    @IBInspectable
    public var headerTextStyle: String = "regular16" {
        didSet {
            header.font = UIFont.scaledNamedFont(UIFont.Name(rawValue: headerTextStyle) ?? .regular16)
        }
    }

    @IBInspectable var subHeaderText: String? {
        didSet {
            subHeader?.text = subHeaderText
        }
    }

    @IBInspectable
    public var subHeaderTextColorName: String = "textDarkest" {
        didSet {
            subHeader.textColor = Brand.shared.color(subHeaderTextColorName) ?? .textDarkest
        }
    }

    @IBInspectable
    public var subHeaderTextStyle: String = "regular16" {
        didSet {
            subHeader.font = UIFont.scaledNamedFont(UIFont.Name(rawValue: subHeaderTextStyle) ?? .regular16)
        }
    }

    @IBInspectable var hideHeader: Bool = false {
        didSet {
            header?.isHidden = !hideHeader
        }
    }

    @IBInspectable var hideSubHeader: Bool = false {
        didSet {
            subHeader?.isHidden = !hideSubHeader
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        contentView = loadFromXib()
        backgroundColor = UIColor.backgroundLightest
        contentView.backgroundColor = UIColor.backgroundLightest
    }
}

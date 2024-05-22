//
//  FeedCell.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-04.
//

import UIKit

class FeedCell: UITableViewCell {
    
    static let identifier = "news-cell-identifier"
    
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        label.accessibilityLabel = "Title of the article"
        return label
    }()
    
    lazy var descriptionLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 3
        label.textColor = .red
        return label
    }()
    
    lazy var pubDateLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
//        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(descriptionLbl)
        contentView.addSubview(pubDateLbl)
        
        newsImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.width.equalTo(150)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(newsImageView)
            make.leading.equalTo(newsImageView.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
        }
        
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(5)
            make.leading.trailing.equalTo(titleLbl)
            make.bottom.equalTo(pubDateLbl.snp.top)
        }
        
        pubDateLbl.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
            make.leading.equalTo(titleLbl)
        }
    }
    
    func configure(with newsItem: News) {
        newsImageView.loadImage(urlString: newsItem.imageUrl)
        titleLbl.text = newsItem.title
        descriptionLbl.text = newsItem.description
        pubDateLbl.text = newsItem.pubDate
    }
    
}

//
//  DetailsViewController.swift
//  Sports
//
//  Created by Fatma_Hassan on 22/05/2023.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var back: UIBarButtonItem!
    
    @IBOutlet weak var favorite: UIBarButtonItem!
    
    @IBOutlet weak var collection: UICollectionView!
    
    var detailsViewModel : DetailsViewModel?
    
    var upcoming : [Event]!
    var latest : [Event]!
    var teams : [Team]!
    
    var sportNumber : Int?
    var leagueId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.center = self.view.center
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        
        detailsViewModel = DetailsViewModel()
        
        detailsViewModel?.bindResultUpComingToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.upcoming = self!.detailsViewModel?.resultUpComing
                indicatorView.stopAnimating()
                self?.collection.reloadData()
            }
        }
    
        detailsViewModel?.getUpComingData(sportNumber: sportNumber ?? 0, leaguesId: leagueId ?? 0)
        
        detailsViewModel?.bindResultLatestToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.latest = self!.detailsViewModel?.resultLatest
                self?.collection.reloadData()
            }
        }

        detailsViewModel?.getLatestData(sportNumber: sportNumber ?? 0, leaguesId: leagueId ?? 0)
        
        detailsViewModel?.bindResultTeamToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.teams = self!.detailsViewModel?.resultTeam
                self?.collection.reloadData()
            }
        }

        detailsViewModel?.getTeamData(sportNumber: sportNumber ?? 0, leaguesId: leagueId ?? 0)

        self.collection.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        
        self.collection.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
        
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
                    switch sectionIndex {
                    case 0 :
                        return self.topSection()
                    case 1 :
                        return self.middleSection()
                    default:
                        return self.bottomSection()
                    }
                }
                collection.setCollectionViewLayout(layout, animated: true)
    }
    
    func topSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(180))
        
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
          , bottom: 0, trailing: 0)
          
      let section = NSCollectionLayoutSection(group: group)
        
          section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
          , bottom: 0, trailing: 0)
        
          section.orthogonalScrollingBehavior = .continuous
          
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
             items.forEach { item in
             let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
             let minScale: CGFloat = 0.8
             let maxScale: CGFloat = 1.0
             let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
             item.transform = CGAffineTransform(scaleX: scale, y: scale)
             }
        }
            
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
                let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                section.boundarySupplementaryItems = [headerSupplementary]
        
         return section
    }
    
    func bottomSection()-> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
            , heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(180)
            , heightDimension: .absolute(200))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
            , subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15
            , bottom: 60, trailing: 10)
            
            let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
        , bottom: 10, trailing: 0)
        
            section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
                let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                section.boundarySupplementaryItems = [headerSupplementary]
        
            return section
        }
    
    
    func middleSection()->NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
            , heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
            , heightDimension: .absolute(180))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
            , subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
            , bottom: 10, trailing: 0)
            
        let section = NSCollectionLayoutSection(group: group)
        
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
            , bottom: 10, trailing: 15)
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
                let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                section.boundarySupplementaryItems = [headerSupplementary]
            
            return section
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return upcoming?.count ?? 0
        }else if section == 1{
            return latest?.count ?? 0
        }else{
            return teams?.count ?? 0
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! DetailsCollectionViewCell
        
        if indexPath.section == 0{
            cell.firstImage.layer.cornerRadius = cell.firstImage.frame.height/2
            cell.firstImage.kf.setImage(
                with: URL(string: upcoming[indexPath.row].home_team_logo ?? ""),
                placeholder: UIImage(named: "placeHolder"))
            
            cell.secondImage.layer.cornerRadius = cell.secondImage.frame.height/2
            cell.secondImage.kf.setImage(
                with: URL(string: upcoming[indexPath.row].away_team_logo ?? ""),
                placeholder: UIImage(named: "placeHolder"))
            
            cell.firstName.text = upcoming[indexPath.row].event_home_team
            cell.secondName.text = upcoming[indexPath.row].event_away_team
            
            cell.dateMatch.text = upcoming[indexPath.row].event_date
            cell.timeMatch.text = upcoming[indexPath.row].event_time
            cell.result.text = "VS"
            
        }else if indexPath.section == 1 {
            cell.firstImage.layer.cornerRadius = cell.firstImage.frame.height/2
            cell.firstImage.kf.setImage(
                with: URL(string: latest[indexPath.row].home_team_logo ?? ""),
                placeholder: UIImage(named: "placeHolder"))
            
            cell.secondImage.layer.cornerRadius = cell.secondImage.frame.height/2
            cell.secondImage.kf.setImage(
                with: URL(string: latest[indexPath.row].away_team_logo ?? ""),
                placeholder: UIImage(named: "placeHolder"))
            
            cell.firstName.text = latest[indexPath.row].event_home_team
            cell.secondName.text = latest[indexPath.row].event_away_team
            
            cell.dateMatch.text = latest[indexPath.row].event_date
            cell.timeMatch.text = latest[indexPath.row].event_time
            cell.result.text = latest[indexPath.row].event_ft_result
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
            
            cell.teamImage.kf.setImage(
                with: URL(string: teams[indexPath.row].team_logo ?? ""),
                placeholder: UIImage(named: "placeHolder"))
            
            cell.teamName.text = teams[indexPath.row].team_name
            
            cell.teamImage.layer.cornerRadius = 30
            
            cell.layer.cornerRadius = 30
            cell.layer.masksToBounds = true
            
            return cell
        }
        
        cell.layer.cornerRadius = 30
        cell.layer.masksToBounds = true
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionReusableView
                
                if indexPath.section == 0 {
                    
                    header.headerTitle.text = "Up Coming Events"
                }else if indexPath.section == 1{
                    header.headerTitle.text = "Latest Results"
                }else{
                    header.headerTitle.text = "Teams"
                }
                
                return header
            }
            return UICollectionReusableView()
        }
    

}

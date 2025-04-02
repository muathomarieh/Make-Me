//
//  ListView.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import SwiftUI
import ConfettiSwiftUI

struct ListSectionView: View {
    
    // MARK: PROPERTIES
    let board: NewBoard
    @StateObject var sectionsVM: SectionViewModel
    init(board: NewBoard) {
        self.board = board
        _sectionsVM = StateObject(wrappedValue: SectionViewModel(boardID: board.id))
    }
    @Environment(\.dismiss) var dismiss

    @State private var showAddTask = false
    @State private var showAddSectionSheet: Bool = false
    @State private var showTaskView: Bool = false

    @State private var selectedSection: NewSection?
    @State private var selectedTask: TaskModel?
    
    @State private var confettiTriggers = [String: Int]()
    @State private var isEditing = false
    
    @State private var sectionProgress: [String: CGFloat] = [:]
    
    // MARK: BODY
    var body: some View {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: Color.theme.accentToWhite
                ),
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            )
            .ignoresSafeArea()
            VStack {
                    
                ListSectionTopBarView(
                    title: "BOARDTITLE",
                    topBarType: .listSection
                ) {
                    isEditing.toggle()
                }
                    
                if sectionsVM.sections.isEmpty {
                    NoItemsView(inBoard: board)
                        .transition(AnyTransition.opacity.animation(.easeIn))
                } else {
                    List {
                        ForEach(sectionsVM.sections) { section in
                            Section {
                                SectionContent(section: section, boardID: board.id) { progress in
                                    sectionProgress[section.id] = progress // Update progress state
                                }
                                addTaskToSection(for: section)
                            } header: {
                                SectionHeaderView(
                                    section: section,
                                    progress: sectionProgress[section.id] ?? 0.0,
                                    confettiTrigger: Binding(
                                        get: { confettiTriggers[section.id] ?? 0 },
                                        set: { confettiTriggers[section.id] = $0 }
                                    )
                                )
                            }
                            .listRowBackground(Color.white)
                        }
                    }
                    .listStyle(.automatic)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            .environment(
                \.editMode,
                 isEditing ? .constant(.active) : .constant(.inactive)
            )
            .sheet(item: $selectedSection) { section in
                AddTask(section: section, inBoard: board)
            }
            
            CircleAddButton {
                showAddSectionSheet.toggle()
            }.sheet(isPresented: $showAddSectionSheet) {
                AddSectionView(board: board)
                    .padding(.top, 20)
                    .presentationDetents([.medium])
                    
            }
                
        }
         
    }
}

// MARK: VIEWS
extension ListSectionView {
    
    struct SectionHeaderView: View {
        let section: NewSection
        let progress: CGFloat
        @Binding var confettiTrigger: Int

        var body: some View {
            HStack {
                Text(section.sectionTitle)
                    .foregroundStyle(.white)
                
                ProgressView("Loading...",
                             value: self.progress,
                             total: 1)
                .progressViewStyle(CustomProgressBar())
                .confettiCannon(trigger: $confettiTrigger, num: 30)
                .onChange(of: progress) {
                    if progress == 1 {
                        confettiTrigger += 1
                    }
                }
            }
            .frame(height: 20)
        }
    }
    
}

// MARK: FUCTIONS
extension ListSectionView {
    
    private func addTaskToSection(for section: NewSection) -> some View {
        AppButton(buttonTitle: Strings.ADD) {
            if selectedSection == nil {
                selectedSection = section
            }
            print(
                "Selected section: \(selectedSection?.sectionTitle ?? "None")"
            )
            showAddTask = true
        }
        .listRowInsets(
            EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        )
    }
    
    
//    private func handleDelete(_ indexSet: IndexSet, for section: Section) {
//        withAnimation(.easeIn) {
//            listViewModel
//                .deleteItem(for: selectedBoard, from: section, at: indexSet)
//        }
//    }
//
//    private func handleMove(
//        _ indexSet: IndexSet,
//        _ destination: Int,
//        for section: Section
//    ) {
//        listViewModel.moveItem(
//            from: indexSet,
//            to: destination,
//            for: section, for: selectedBoard
//        )
//    }
    
}


#Preview {
    NavigationStack {
        ListSectionView(
            board: NewBoard(boardName: "Board1", boardImage: "testImage", creatorId: "1234")
        )
    }
    .environmentObject(AppViewModel())
}



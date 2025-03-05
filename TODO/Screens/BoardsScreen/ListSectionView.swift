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
    let selectedBoard: BoardModel
    
    @Environment(ListViewModel.self) var listViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var showAddTask = false
    @State private var showAddSectionSheet: Bool = false
    @State private var showTaskView: Bool = false

    @State private var selectedSection: SectionModel?
    @State private var selectedTask: ItemModel?
    
    @State private var confettiTriggers = [String: Int]()
    @State private var isEditing = false
    
    // MARK: BODY
    var body: some View {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: Colors.accentToWhite
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
                } xmarkClicked: {
                    dismiss()
                }
                    
                if listViewModel.isSectionsEmptyInTheBoard(for: selectedBoard) {
                    NoItemsView(inBoard: selectedBoard)
                        .transition(AnyTransition.opacity.animation(.easeIn))
                } else {
                    List {
                        ForEach(
                            listViewModel
                                .boards[listViewModel.getBoardIndex(
                                    for: selectedBoard
                                )].boardSections
                        ) { section in
                            Section {
                                sectionContent(for: section)
                                addTaskToSection(for: section)
                            } header: {
                                SectionHeaderView(
                                    section: section,
                                    confettiTrigger: Binding(
                                        get: {
                                            confettiTriggers[section.id] ?? 0
                                        },
                                        set: {
                                            confettiTriggers[section.id] = $0
                                        }
                                    )
                                )
                            }
                                
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
            .sheet(item: $selectedTask) { selectedTask in
                if let section = listViewModel.sectionForSelectedTask(selectedTask, board: selectedBoard) {
                    TaskView(
                        selectedTask: selectedTask,
                        inSection: section,
                        inBoard: selectedBoard
                    )
                } else {
                    Text("Task not founded")
                }
            }
            .sheet(item: $selectedSection) { section in
                AddTask(selectedSection: section, inBoard: selectedBoard)
            }
            
            CircleAddButton {
                showAddSectionSheet.toggle()
            }.sheet(isPresented: $showAddSectionSheet) {
                AddSectionView(inBoard: selectedBoard)
                    .padding(.top, 20)
                    .presentationDetents([.medium])
                    
            }
                
        }
         
    }
}

// MARK: VIEWS
extension ListSectionView {
    
    struct SectionHeaderView: View {
        let section: SectionModel
        @Binding var confettiTrigger: Int
        @Environment(ListViewModel.self) var listViewModel
        
        var body: some View {
            HStack {
                Text(section.sectionTitle)
                    .foregroundStyle(.white)
                
                ProgressView("Loading...",
                             value: listViewModel
                    .completedFractions(for: section),
                             total: 1)
                .progressViewStyle(CustomProgressBar())
                .confettiCannon(trigger: $confettiTrigger, num: 30)
                .onChange(of: listViewModel.completedFractions(for: section)) {
                    if listViewModel.completedFractions(for: section) == 1 {
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
    
    private func addTaskToSection(for section: SectionModel) -> some View {
        AppButton(buttonTitle: "Add") {
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
    
    private func taskRow(for task: ItemModel, in section: SectionModel) -> some View {
        Button {
            selectedTask = task
            print("Selected Task: \(selectedTask?.title ?? "None")")
        } label: {
            ListRowView(item: task) {
                withAnimation(.linear) {
                    listViewModel
                        .updateItemCheckmark(
                            item: task,
                            forSection: section,
                            forBoard: selectedBoard
                        )
                }
            }
        }
//        .sheet(item: $selectedTask) { selectedTask in
//            TaskView(
//                selectedTask: selectedTask,
//                inSection: section,
//                inBoard: selectedBoard
//            )
//        }
    }
    
    private func sectionContent(for section: SectionModel) -> some View {
        ForEach(section.sectionItems) { task in
            taskRow(for: task, in: section)
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button("Check") {
                        withAnimation {
                            listViewModel
                                .updateItemCheckmark(
                                    item: task,
                                    forSection: section,
                                    forBoard: selectedBoard
                                )
                        }
                    }
                }
        }
        .onDelete { indexSet in
            handleDelete(indexSet, for: section)
        }
        .onMove { indexSet, destination in
            handleMove(indexSet, destination, for: section)
        }
        
    }
    
    private func headerContent(for section: SectionModel) -> some View {
        SectionHeaderView(
            section: section,
            confettiTrigger: Binding(
                get: { confettiTriggers[section.id] ?? 0 },
                set: { confettiTriggers[section.id] = $0 }
            )
        )
    }
    
    private func handleDelete(_ indexSet: IndexSet, for section: SectionModel) {
        withAnimation(.easeIn) {
            listViewModel
                .deleteItem(for: selectedBoard, from: section, at: indexSet)
        }
    }

    private func handleMove(
        _ indexSet: IndexSet,
        _ destination: Int,
        for section: SectionModel
    ) {
        listViewModel.moveItem(
            from: indexSet,
            to: destination,
            for: section, for: selectedBoard
        )
    }
    
}


#Preview {
    NavigationStack {
        ListSectionView(
            selectedBoard: BoardModel(
                boardName: "Board1",
                boardImage: "testImage",
                isFavorite: true,
                boardSections: [
                    SectionModel(
                        sectionTitle: "Section",
                        sectionItems: [ItemModel(
                            title: "ItemModelTitle",
                            description: "Hello",
                            startingTime: Date(),
                            isCompleted: true,
                            remindMe: false, priority: Strings.Blue
                        )]
                    )
                ]
            )
        )
    }
    .environment(ListViewModel())
}



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
    @Environment(ListViewModel.self) var listViewModel
    @State private var showAddTask = false
    @State private var selectedSection: SectionModel?
    @State private var showAddSectionSheet: Bool = false
    @State private var confettiTriggers = [String: Int]()
    
    // MARK: BODY
    var body: some View {
        ZStack {
            
            if listViewModel.sections.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listViewModel.sections) { section in
                        Section {
                            sectionContent(for: section)
                            addTaskToSection(for: section)
                        } header: {
                            SectionHeaderView(
                                section: section,
                                confettiTrigger: Binding(
                                    get: { confettiTriggers[section.id] ?? 0 },
                                    set: { confettiTriggers[section.id] = $0 }
                                )
                            )
                        }
                    }
                }
                .listStyle(.automatic)
                .navigationTitle("Todo List 📝")
                .navigationDestination(isPresented: $showAddTask) {
                    if let sectionAddTaskTo = selectedSection {
                        AddTask(selectedSection: sectionAddTaskTo)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        showAddSectionSheet.toggle()
                    }
                } label: {
                    Text("Section")
                        .foregroundStyle(Color.accentColor)
                }
            }
        }
        .sheet(isPresented: $showAddSectionSheet) {
            AddSectionView()
                .padding(.top, 20)
                .presentationDetents([.medium])
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
                ProgressView("Loading...",
                             value: listViewModel.completedFractions(for: section),
                             total: 1)
                .progressViewStyle(CustomProgressBar())
                .confettiCannon(trigger: $confettiTrigger, num: 50)
                .onChange(of: listViewModel.completedFractions(for: section), {
                    if listViewModel.completedFractions(for: section) == 1 {
                        confettiTrigger += 1
                    }
                })
            }
            .frame(height: 20)
        }
    }
}

// MARK: FUCTIONS
extension ListSectionView {
    
    private func addTaskToSection(for section: SectionModel) -> some View {
        Button {
            selectedSection = section
            showAddTask = true
        } label: {
            Text("Add".uppercased())
                .foregroundStyle(.white)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    Color.accentColor
                )
                .cornerRadius(8)
        }
        .listRowInsets(
            EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        )
    }
    
    private func taskRow(for task: ItemModel, in section: SectionModel) -> some View {
        NavigationLink {
            TaskView(
                selectedTask: task,
                inSection: section
            )
        } label: {
            ListRowView(item: task) {
                withAnimation(.linear) {
                    listViewModel
                        .updateItemCheckmark(
                            item: task,
                            for: section
                        )
                }
            }
        }
    }
    
    private func sectionContent(for section: SectionModel) -> some View {
        ForEach(section.sectionItems) { task in
            taskRow(for: task, in: section)
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button("Check") {
                        listViewModel
                            .updateItemCheckmark(
                                item: task,
                                for: section
                            )
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
            listViewModel.deleteItem(from: section, at: indexSet)
        }
    }

    private func handleMove(_ indexSet: IndexSet, _ destination: Int, for section: SectionModel) {
        listViewModel.moveItem(
            from: indexSet,
            to: destination,
            for: section
        )
    }
    
}


#Preview {
    NavigationStack {
        ListSectionView()
    }
    .environment(ListViewModel())
}


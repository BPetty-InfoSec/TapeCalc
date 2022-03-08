//
//  ContentView.swift
//  Shared
//
//  Created by Brian Petty on 2/26/22.
//

import SwiftUI

struct ContentView: View {
	
	class logLine: Identifiable, ObservableObject {
		var id = UUID()
		var lineNotes: String? {
			willSet {
				objectWillChange.send()
			}
		}
		var lineText: String?
		var lineSign: String?
		var lineValue: Double?
		
		init(lineNotes: String? = nil,
			 lineText: String? = nil,
			 lineSign: String? = nil,
			 lineValue: Double? = nil)
		{
			self.lineNotes = lineNotes
			self.lineText = lineText
			self.lineSign = lineSign
			self.lineValue = lineValue
		}
	}
	
	let defaultLogLine = logLine(lineNotes: "Begin Tape Run", lineText: "0", lineSign: "", lineValue: 0)
	
	let buttonSize: CGFloat = 50
	
	@State var currentNumber: String = "0"
	@State var usingSign: String = "+"
	@State var runningTotal: Double = 0.0
	@State var logRoll: [logLine] = [logLine(lineNotes: "Begin Tape Run", lineText: "0", lineSign: "", lineValue: 0)]
	
	@State var showingPopover: Bool = false
	@State var tempNote: String = ""
	
    var body: some View {
		
		VStack {

			Section {
				ScrollViewReader { proxy in
					List {
						Section {
							ForEach(logRoll) { line in
								HStack(spacing: 5) {
									Button {
										showingPopover = true
									} label: {
										Image(systemName: "pencil.circle")
									}
									.frame(alignment: .leading)
									.popover(isPresented: $showingPopover) {
										VStack {
											
											TextField("Enter the note for this line", text: $tempNote)
												.foregroundColor(.white)
												.padding()
												
											Button {
												editNote(lineID: line.id, noteString: tempNote)
												showingPopover = false
											} label: {
												Text("Done")
											}
											.keyboardShortcut(.defaultAction)
										}
										.padding()
									}
								
									Spacer()
										.frame(minWidth: 5, maxWidth: 15)
									
									Text(line.lineNotes!)
										.frame(alignment: .center)
									
									Spacer()
										.frame(minWidth: 5, maxWidth: 500)
									
									Text(line.lineText!)
										.frame(alignment: .trailing)
									
									Spacer()
										.frame(minWidth: 5, maxWidth: 10)
									
									switch line.lineSign! {
										case "+":
											Image(systemName: "plus")
										case "-":
											Image(systemName: "minus")
										case "/":
											Image(systemName: "divide")
										case "X":
											Image(systemName: "multiply")
										case "=":
											Image(systemName: "equal")
										default:
											Image(systemName: "scroll")
									}
																
									Spacer()
										.frame(minWidth: 2, maxWidth: 2)
								}
								.frame(maxWidth: .infinity)
								.foregroundColor(Color.black)
							}
							.background(Color.white)
						} header: {
							Text("Tape Roll")
						} 					}
					.listStyle(.sidebar)
				}
				
				Spacer()
				
				Text("Current Total: \(runningTotal)")
					.font(.caption)
					.foregroundColor(.blue)
				
				Text(currentNumber)
					.font(.system(size: 20, weight: .light))
					.frame(width: 300, alignment: .trailing)
					.padding(5)
					.border(Color.blue, width: 2)
				
			}
			
			Spacer()
				.frame(maxHeight: 15)

			Section {
				VStack {
					HStack {

						Button {
							doPress(keyPressed: "AC")
						} label: {
							Text("AC")
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(.red)
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut(.cancelAction)

						Button {
							doPress(keyPressed: "+-")
						} label: {
							Image(systemName: "plus.forwardslash.minus")
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(.blue)
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("-", modifiers: .command)

						Button {
							doPress(keyPressed: "%")
						} label: {
							Image(systemName: "percent")
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(.blue)
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("%", modifiers: [.shift])

						Spacer()
							.frame(maxWidth: 20)

						Button {
							doPress(keyPressed: "/")
						} label: {
							Image(systemName: "divide")
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(.blue)
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("/", modifiers: [])
					}

					HStack {
						
						Button {
							doPress(keyPressed: "7")
						} label: {
							Text("7")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("7", modifiers: [])

						Button {
							doPress(keyPressed: "8")
						} label: {
							Text("8")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("8", modifiers: [])
						
						Button {
							doPress(keyPressed: "9")
						} label: {
							Text("9")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("9", modifiers: [])
						
						Spacer()
							.frame(maxWidth: 20)
						
						Button {
							doPress(keyPressed: "*")
						} label: {
							Image(systemName: "multiply")
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(.blue)
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("*", modifiers: [.shift])
						.keyboardShortcut("x", modifiers: [])
					}
					
					HStack {
					
						Button {
							doPress(keyPressed: "4")
						} label: {
							Text("4")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("4", modifiers: [])

						Button {
							doPress(keyPressed: "5")
						} label: {
							Text("5")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("5", modifiers: [])

						Button {
							doPress(keyPressed: "6")
						} label: {
							Text("6")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("6", modifiers: [])

						Spacer()
							.frame(maxWidth: 20)

						Button {
							doPress(keyPressed: "-")
						} label: {
							Image(systemName: "minus")
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(.blue)
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("-", modifiers: [])
						
					}

					HStack {

						Button {
							doPress(keyPressed: "1")
						} label: {
							Text("1")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("1", modifiers: [])

						Button {
							doPress(keyPressed: "2")
						} label: {
							Text("2")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("2", modifiers: [])

						Button {
							doPress(keyPressed: "3")
						} label: {
							Text("3")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("3", modifiers: [])

						Spacer()
							.frame(maxWidth: 20)

						Button {
							doPress(keyPressed: "+")
						} label: {
							Image(systemName: "plus")
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(.blue)
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("+", modifiers: [.shift])
					}

					HStack {

						Button {
							doPress(keyPressed: "00")
						} label: {
							Text("00")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("0", modifiers: .command)

						Button {
							doPress(keyPressed: "0")
						} label: {
							Text("0")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut("0", modifiers: [])

						Button {
							doPress(keyPressed: ".")
						} label: {
							Text(".")
								.font(.title)
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(Color(red: 0.45, green: 0.45, blue: 0.45))
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut(".", modifiers: [])

						Spacer()
							.frame(maxWidth: 20)

						Button {
							doPress(keyPressed: "=")
						} label: {
							Image(systemName: "equal")
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(.blue)
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())
						.keyboardShortcut(.defaultAction)
						.keyboardShortcut("=", modifiers: [])
						
					}
					
				}
				
			}
			
			Spacer()
			
			TextField("Enter a note for this line...", text: $tempNote)
			
			Spacer()
			
		}
		.frame(minWidth: 300, maxWidth: 600, maxHeight: .infinity)
    }
	
	/// doPress(keyPressed as String) - Logic to handle buttons pressed on calculator
	/// - Parameter keyPressed: Text showing which button was pressed
	func doPress(keyPressed: String) {
		
		if currentNumber == "0" {
			if keyPressed != "." {
				currentNumber = ""
			}
		}
//		This switch statement contains the logic for button presses
		switch keyPressed {
//			Handle numbers and decimals being pressed
			case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "00", ".":
				currentNumber += keyPressed
			case "AC":
//				Handle the AC button, clearing the tape roll, etc.
				logRoll.removeAll()
				currentNumber = "0"
				runningTotal = 0.0
				logRoll.append(logLine(lineNotes: defaultLogLine.lineNotes, lineText: defaultLogLine.lineText, lineSign: defaultLogLine.lineSign, lineValue: defaultLogLine.lineValue))
				tempNote = ""
//			Switch the sign for the current number
			case "+-":
				if currentNumber[currentNumber.startIndex] == "-" {
					currentNumber.remove(at: currentNumber.startIndex)
				} else {
					if currentNumber == "0" {
						currentNumber = "-"
					} else {
						currentNumber = "-" + currentNumber
					}
				}
//			Handle addition
			case "+":
				runningTotal += Double(currentNumber)!
				logRoll.append(logLine(lineNotes: tempNote, lineText: currentNumber, lineSign: "+", lineValue: runningTotal))
				currentNumber = "0"
				tempNote = ""
//			Handle subtraction
			case "-":
				runningTotal = runningTotal - Double(currentNumber)!
				logRoll.append(logLine(lineNotes: tempNote, lineText: currentNumber, lineSign: "-", lineValue: runningTotal))
				currentNumber = "0"
				tempNote = ""
//			Handle multiplication
			case "*":
				runningTotal = runningTotal * Double(currentNumber)!
				logRoll.append(logLine(lineNotes: tempNote, lineText: currentNumber, lineSign: "X", lineValue: runningTotal))
				currentNumber = "0"
				tempNote = ""
//			Handle division
			case "/":
				runningTotal = runningTotal / Double(currentNumber)!
				logRoll.append(logLine(lineNotes: tempNote, lineText: currentNumber, lineSign: "/", lineValue: runningTotal))
				currentNumber = "0"
				tempNote = ""
//			Handle percentages
			case "%":
				runningTotal = runningTotal * (Double(currentNumber)!/100)
				logRoll.append(logLine(lineNotes: tempNote, lineText: currentNumber, lineSign: "%", lineValue: runningTotal))
				currentNumber = "0"
				tempNote = ""
//			Handle totalling the current run
			case "=":
				if tempNote == "" {
					logRoll.append(logLine(lineNotes: "End of Roll", lineText: String(runningTotal), lineSign: "=", lineValue: runningTotal))
				} else {
					logRoll.append(logLine(lineNotes: tempNote, lineText: String(runningTotal), lineSign: "=", lineValue: runningTotal))
				}
				tempNote = ""
//			Error trapping. This should never be triggered.
			default:
				print("An error occurred. You shouldn't be able to get here.")
		}
	}
	
	/// Function for editing the notes on a line of the tape roll
	/// - Parameter lineID: This is the UUID assigned to the line when created.
	func editNote(lineID: UUID, noteString: String) {
		// Pops up a view that allows text to be entered and/or edited
		// Also needs cancel and done buttons.
		
		for line in logRoll {
			if line.id == lineID {
				line.lineNotes = noteString
				tempNote = ""
				showingPopover = false
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
	}
}

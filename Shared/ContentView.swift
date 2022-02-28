//
//  ContentView.swift
//  Shared
//
//  Created by Brian Petty on 2/26/22.
//

import SwiftUI

struct ContentView: View {
	
	struct logLine: Identifiable {
		var id = UUID()
		var lineNotes: String?
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
//	@State var prevNumber: Double = 0.0
	@State var usingSign: String = "+"
	@State var runningTotal: Double = 0.0
	@State var logRoll: [logLine] = [logLine(lineNotes: "Begin Tape Run", lineText: "0", lineSign: "", lineValue: 0)]
	
    var body: some View {
		
		VStack {

			Section {
				
				List {
					ForEach(logRoll) { line in
						HStack(spacing: 5) {
							Button {
								editNote(lineID: line.id)
							} label: {
								Image(systemName: "pencil.circle")
							}
							.frame(alignment: .leading)
							
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
							
							Text(line.lineSign!)
								.frame(alignment: .trailing)
							
							Spacer()
								.frame(minWidth: 2, maxWidth: 2)
						}
						.frame(maxWidth: .infinity)
						.foregroundColor(Color.black)
					}
					.background(Color.white)

				}
				
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

						Button {
							doPress(keyPressed: "+-")
						} label: {
							Image(systemName: "plus.forwardslash.minus")
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(.blue)
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())

						Button {
							doPress(keyPressed: "%")
						} label: {
							Image(systemName: "percent")
								.frame(maxWidth: buttonSize, maxHeight: buttonSize)
								.background(.blue)
								.clipShape(Capsule())
						}
						.buttonStyle(PlainButtonStyle())

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
					}
				}
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
	
	func doPress(keyPressed: String) {
		
		if currentNumber == "0" {
			if keyPressed != "." {
				currentNumber = ""
			}
		}
		switch keyPressed {
			case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "00", ".":
				currentNumber += keyPressed
			case "AC":
				logRoll.removeAll()
				currentNumber = "0"
				runningTotal = 0.0
				logRoll.append(logLine(lineNotes: defaultLogLine.lineNotes, lineText: defaultLogLine.lineText, lineSign: defaultLogLine.lineSign, lineValue: defaultLogLine.lineValue))
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
			case "+":
				runningTotal += Double(currentNumber)!
				logRoll.append(logLine(lineNotes: "", lineText: currentNumber, lineSign: "+", lineValue: runningTotal))
				currentNumber = "0"
			case "-":
				runningTotal = runningTotal - Double(currentNumber)!
				logRoll.append(logLine(lineNotes: "", lineText: currentNumber, lineSign: "-", lineValue: runningTotal))
				currentNumber = "0"
			case "*":
				runningTotal = runningTotal * Double(currentNumber)!
				logRoll.append(logLine(lineNotes: "", lineText: currentNumber, lineSign: "X", lineValue: runningTotal))
				currentNumber = "0"
			case "/":
				runningTotal = runningTotal / Double(currentNumber)!
				logRoll.append(logLine(lineNotes: "", lineText: currentNumber, lineSign: "/", lineValue: runningTotal))
				currentNumber = "0"
			case "%":
				runningTotal = runningTotal * (Double(currentNumber)!/100)
				logRoll.append(logLine(lineNotes: "", lineText: currentNumber, lineSign: "%", lineValue: runningTotal))
				currentNumber = "0"
			case "=":
					logRoll.append(logLine(lineNotes: "End of Roll", lineText: String(runningTotal), lineSign: "=", lineValue: runningTotal))
			default:
				print("An error occurred. You shouldn't be able to get here.")
		}
	}
	
	func editNote(lineID: UUID) {
		
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
	}
}

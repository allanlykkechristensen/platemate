//
//  WarmUpSchemaTests.swift
//  PlateMate - Gym BuddyTests
//
//  Created by Allan Lykke Christensen on 13/02/2025.
//

import Testing
@testable import PlateMate___Gym_Buddy

// MARK: - Unit Tests
struct WarmUpSchemaTests {

    @Test func testCalculcate_withPercentageBasedSets() async throws {
        let sut = warmUpSchemaWithTwoWarmUpSetsTestDouble()

        let expectedWarmUpSets = [
            ActualWarmUpSet(reps: 10, load: 50.0, percent: 0.5),
            ActualWarmUpSet(reps: 5, load: 75.0, percent: 0.75)
        ]

        let result = sut.calculate(workingLoad: 100, weightIncrement: 1.25)
        let matches = result.filter { actualWarmUpSet in
            expectedWarmUpSets.contains {
                actualWarmUpSet.load == $0.load &&
                actualWarmUpSet.percent == $0.percent &&
                actualWarmUpSet.reps == $0.reps
            }
        }

        #expect(!result.isEmpty, "No warm up sets calculated")
        #expect(result.count == expectedWarmUpSets.count, "Incorrect number of warm up sets returned")
        #expect(result.count == matches.count, "Incorrect reps, load, or percentage returned")
    }

    @Test func testCalculate_WithSpecificLoad() throws {
        let sut = warmUpSchemaWithSpecificLoadAndTwoPercentSetsTestDouble()

        let expectedWarmUpSets = [
            ActualWarmUpSet(reps: 10, load: 20.0, percent: 0.2),
            ActualWarmUpSet(reps: 10, load: 50.0, percent: 0.5),
            ActualWarmUpSet(reps: 5, load: 75.0, percent: 0.75)
        ]

        let result = sut.calculate(workingLoad: 100, weightIncrement: 1.25)

        let matches = result.filter { actualWarmUpSet in
            expectedWarmUpSets.contains {
                actualWarmUpSet.load == $0.load &&
                actualWarmUpSet.percent == $0.percent &&
                actualWarmUpSet.reps == $0.reps
            }
        }

        #expect(result.count == matches.count, "Incorrect reps, load, or percentage returned")
    }

}

// MARK: - Test configuration

func warmUpSchemaWithTwoWarmUpSetsTestDouble() -> WarmUpSchema {
    return WarmUpSchema(
        id: .init(),
        name: "50/75",
        note: "Two Warm Up Sets",
        sets: [
            WarmUpSchemaSet(id: .init(), reps: 10, percentageOfWorkingLoad: 0.5),
            WarmUpSchemaSet(id: .init(), reps: 5, percentageOfWorkingLoad: 0.75)]
    )
}

func warmUpSchemaWithSpecificLoadAndTwoPercentSetsTestDouble() -> WarmUpSchema {
    return WarmUpSchema(
        id: .init(),
        name: "Bar/50/75",
        note: "Specific Load + Two Warm Up Sets",
        sets: [
            WarmUpSchemaSet(id: .init(), reps: 10, fixedLoad: 20.0),
            WarmUpSchemaSet(id: .init(), reps: 10, percentageOfWorkingLoad: 0.5),
            WarmUpSchemaSet(id: .init(), reps: 5, percentageOfWorkingLoad: 0.75)
        ])
}

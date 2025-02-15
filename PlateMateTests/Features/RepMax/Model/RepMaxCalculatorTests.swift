//
//  RepMaxCalculatorTests.swift
//  PlateMate - Gym BuddyTests
//
//  Created by Allan Lykke Christensen on 15/02/2025.
//

import Testing
@testable import PlateMate___Gym_Buddy

struct RepMaxCalculatorTests {

    @Test func test_calculateRepMax_estimated1RM() async throws {
        let sut = RepMaxCalculator(reps: 5, load: 110.0, increment: 10.0)

        let actual1rm = sut.calculateRepMaxLoad(reps: 1)
        let expected1rm = 130.0

        #expect(actual1rm == expected1rm, "No warm up sets calculated")
    }

    @Test func test_calculcateRepMax_estimated1RMBasedon5RM() async throws {
        let sut = RepMaxCalculator(reps: 5, load: 110.0, increment: 2.5)

        let actualRM1 = sut.calculateRepMaxLoad(reps: 1)
        let expectedRM1 = 130.0

        #expect(actualRM1 == expectedRM1)
    }

    @Test func test_calculateRepMax_estimated1RMBasedon1RM() async throws {
        let sut = RepMaxCalculator(reps: 1, load: 110.0, increment: 2.5)

        let actualRM1 = sut.calculateRepMaxLoad(reps: 1)
        let expectedRM1 = 110.0

        #expect(actualRM1 == expectedRM1)
    }

    @Test func test_calculateIntensity_withRepsAndLoad() async throws {
        let sut = RepMaxCalculator(reps: 5, load: 110.0)

        let actualIntensity = sut.calculateIntensity(reps: 1, load: 130.0)
        let expectedIntensity = 1.0

        #expect(actualIntensity == expectedIntensity)
    }

    @Test func test_calculateIntensity_withSameRepsAndLoad() async throws {
        let sut = RepMaxCalculator(reps: 5, load: 110.0)

        let actualIntensity = sut.calculateIntensity(reps: 5, load: 110.0)
        let expectedIntensity = 1.0

        #expect(actualIntensity == expectedIntensity)
    }

    @Test func test_calculateIntensity_withNoRepMax() async throws {
        let sut = RepMaxCalculator(reps: 0, load: 0)

        let actualIntensity = sut.calculateIntensity(reps: 5, load: 110.0)
        let expectedIntensity = 1.0

        #expect(actualIntensity == expectedIntensity)
    }

    @Test func test_calculateIntensity_withRepsLessThanRepMax() async throws {
        let sut = RepMaxCalculator(reps: 10, load: 100)

        let actualIntensity = sut.calculateIntensity(reps: 5)
        let expectedIntensity = 0.83

        #expect(actualIntensity == expectedIntensity)
    }

    @Test func test_calculcateIntensity_withNoReps() async throws {
        let sut = RepMaxCalculator(reps: 10, load: 100)

        let actualIntensity = sut.calculateIntensity(reps: 0)
        let expectedIntensity = 0.0

        #expect(actualIntensity == expectedIntensity)
    }

    @Test func test_calculcateIntensity_withNoPreviousRepMax() async throws {
        let sut = RepMaxCalculator(reps: 0, load: 0)

        let actualIntensity = sut.calculateIntensity(reps: 10)
        let expectedIntensity = 1.0

        #expect(actualIntensity == expectedIntensity)
    }

    @Test func test_calculateLoad_byIntensity() async throws {
        let sut = RepMaxCalculator(reps: 5, load: 110.0)

        let actualWeight = sut.calculateLoad(intensity: 0.80)
        let expectedWeight = 105.0

        #expect(actualWeight == expectedWeight)
    }

    @Test func test_calculateLoad_100Percent() async throws {
        let sut = RepMaxCalculator(reps: 5, load: 110.0)

        let actualWeight = sut.calculateLoad(intensity: 1.0)
        let expectedWeight = 110.0

        #expect(actualWeight == expectedWeight)
    }

    @Test func test_calculateLoad_byIntensityWithoutRepMax() async throws {
        let sut = RepMaxCalculator(reps: 0, load: 0)

        let actualWeight = sut.calculateLoad(intensity: 0.80)
        let expectedWeight = 0.0

        #expect(actualWeight == expectedWeight)
    }

    @Test func test_calculateLoad_byIntensityWithNoIncrement() async throws {
        let sut = RepMaxCalculator(reps: 5, load: 110.0, increment: 0.0)

        let actualWeight = sut.calculateLoad(intensity: 0.80)
        let expectedWeight = 0.0

        #expect(actualWeight == expectedWeight)
    }

    @Test func test_calculateLoad_forRIR() async throws {
        let sut = RepMaxCalculator(reps: 10, load: 100)

        let actualWeight = sut.calculateLoad(intensityType: .rir(rir: 2), reps: 8)
        let expectedWeight = 100.0

        #expect(actualWeight == expectedWeight)
    }

    @Test func test_calculcateLoad_forRPE() async throws {
        let sut = RepMaxCalculator(reps: 10, load: 100)

        let actualWeight = sut.calculateLoad(intensityType: .rpe(rpe: 8), reps: 8)
        let expectedWeight = 100.0

        #expect(actualWeight == expectedWeight)
    }

    @Test func test_calcilcateLoad_forOtherIntensityType() async throws {
        let sut = RepMaxCalculator(reps: 10, load: 100)

        let actualWeight = sut.calculateLoad(intensityType: .manual, reps: 10)
        let expectedWeight = 100.0

        #expect(actualWeight == expectedWeight)

    }

}

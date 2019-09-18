package parser

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func createTestStack() TestResultMarkerStack {
	return TestResultMarkerStack{
		TestResultMarker{
			TestName:    "TestSnafu",
			IndentLevel: 0,
		},
		TestResultMarker{
			TestName:    "TestSnafu/Situation",
			IndentLevel: 4,
		},
		TestResultMarker{
			TestName:    "TestSnafu/Normal",
			IndentLevel: 4,
		},
	}
}

// Test that pushing items to the stack appends to the list
func TestStackPush(t *testing.T) {
	t.Parallel()

	markers := createTestStack()
	newMarker := TestResultMarker{
		TestName:    "TestThatEverythingWorks",
		IndentLevel: 0,
	}
	markers = markers.push(newMarker)
	assert.Equal(t, len(markers), 4)
	assert.Equal(t, markers[3], newMarker)
}

// Test that popping items off the stack will remove it from the stack and return the LAST item in list
func TestStackPop(t *testing.T) {
	t.Parallel()

	originalMarkers := createTestStack()
	markers := createTestStack()
	markers, poppedMarker := markers.pop()
	assert.Equal(t, poppedMarker, originalMarkers[2])
	assert.Equal(t, len(markers), 2)
	markers, poppedMarker = markers.pop()
	assert.Equal(t, poppedMarker, originalMarkers[1])
	assert.Equal(t, len(markers), 1)
	markers, poppedMarker = markers.pop()
	assert.Equal(t, poppedMarker, originalMarkers[0])
	assert.Equal(t, len(markers), 0)
}

// Test that popping item off an empty stack will return an empty TestResultMarker
func TestStackPopEmpty(t *testing.T) {
	t.Parallel()

	markers := TestResultMarkerStack{}
	markers, poppedMarker := markers.pop()
	assert.Equal(t, len(markers), 0)
	assert.Equal(t, poppedMarker, NULL_TEST_RESULT_MARKER)
}

// Test that peek will return the LAST item in the list WITHOUT removing it.
func TestPeek(t *testing.T) {
	t.Parallel()

	originalMarkers := createTestStack()
	markers := createTestStack()
	peekedMarker := markers.peek()
	assert.Equal(t, peekedMarker, originalMarkers[2])
	assert.Equal(t, originalMarkers, markers)
}

// Test that peeking an empty stack will return an empty TestResultMarker
func TestPeekEmpty(t *testing.T) {
	t.Parallel()

	markers := TestResultMarkerStack{}
	peekedMarker := markers.peek()
	assert.Equal(t, len(markers), 0)
	assert.Equal(t, peekedMarker, NULL_TEST_RESULT_MARKER)
}

// Test isEmpty only returns True on empty stack
func TestIsEmpty(t *testing.T) {
	t.Parallel()

	emptyMarkerStack := TestResultMarkerStack{}
	fullMarkerStack := createTestStack()
	assert.True(t, emptyMarkerStack.isEmpty())
	assert.False(t, fullMarkerStack.isEmpty())
}

// Test that removeDedentedTestResultMarkers remove items that are dedented from the current level, assuming the stack
// is ordered by indent level.
func TestRemoveDedentedTestResultMarkers(t *testing.T) {
	t.Parallel()

	originalMarkers := createTestStack()
	newMarkers := originalMarkers.removeDedentedTestResultMarkers(2)
	assert.Equal(t, len(newMarkers), 1)
	assert.Equal(t, newMarkers, originalMarkers[:1])
}

// Test that removeDedentedTestResultMarkers handles empty stack.
func TestRemoveDedentedTestResultMarkersEmpty(t *testing.T) {
	t.Parallel()

	originalMarkers := TestResultMarkerStack{}
	newMarkers := originalMarkers.removeDedentedTestResultMarkers(2)
	assert.Equal(t, len(newMarkers), 0)
}

// Test that removeDedentedTestResultMarkers handles removing everything
func TestRemoveDedentedTestResultMarkersAll(t *testing.T) {
	t.Parallel()

	originalMarkers := TestResultMarkerStack{}
	newMarkers := originalMarkers.removeDedentedTestResultMarkers(-1)
	assert.Equal(t, len(newMarkers), 0)
}

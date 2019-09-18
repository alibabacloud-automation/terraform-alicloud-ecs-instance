package parser

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGetIndent(t *testing.T) {
	t.Parallel()

	testCases := []struct {
		name string
		in   string
		out  string
	}{
		{
			"BaseCase",
			"    --- FAIL: TestSnafu",
			"    ",
		},
		{
			"NoIndent",
			"--- FAIL: TestSnafu",
			"",
		},
		{
			"EmptyString",
			"",
			"",
		},
		{
			"Tabs",
			"\t\t---FAIL: TestSnafu",
			"\t\t",
		},
		{
			"MixTabSpace",
			"\t    ---FAIL: TestSnafu",
			"\t    ",
		},
	}

	for _, testCase := range testCases {
		testCase := testCase
		t.Run(testCase.name, func(t *testing.T) {
			assert.Equal(
				t,
				getIndent(testCase.in),
				testCase.out,
			)
		})
	}
}

func TestGetTestNameFromResultLine(t *testing.T) {
	t.Parallel()

	testCases := []struct {
		name string
		in   string
		out  string
	}{
		{
			"BaseCase",
			"--- PASS: TestGetTestNameFromResultLine (0.00s)",
			"TestGetTestNameFromResultLine",
		},
		{
			"Indented",
			"    --- PASS: TestGetTestNameFromResultLine/Indented (0.00s)",
			"TestGetTestNameFromResultLine/Indented",
		},
		{
			"SpecialChars",
			"    --- PASS: TestGetTestNameFromResultLine/SpecialChars---_FAIL (0.00s)",
			"TestGetTestNameFromResultLine/SpecialChars---_FAIL",
		},
		{
			"WhenFailed",
			"--- FAIL: TestGetTestNameFromResultLine (0.00s)",
			"TestGetTestNameFromResultLine",
		},
	}

	for _, testCase := range testCases {
		testCase := testCase
		t.Run(testCase.name, func(t *testing.T) {
			assert.Equal(
				t,
				getTestNameFromResultLine(testCase.in),
				testCase.out,
			)
		})
	}
}

func TestIsResultLine(t *testing.T) {
	t.Parallel()

	testCases := []struct {
		name string
		in   string
		out  bool
	}{
		{
			"BaseCase",
			"--- PASS: TestIsResultLine (0.00s)",
			true,
		},
		{
			"Indented",
			"    --- PASS: TestIsResultLine/Indented (0.00s)",
			true,
		},
		{
			"SpecialChars",
			"    --- PASS: TestIsResultLine/SpecialChars---_FAIL (0.00s)",
			true,
		},
		{
			"WhenFailed",
			"--- FAIL: TestIsResultLine (0.00s)",
			true,
		},
		{
			"NonResultLine",
			"=== RUN TestIsResultLine",
			false,
		},
	}

	for _, testCase := range testCases {
		testCase := testCase
		t.Run(testCase.name, func(t *testing.T) {
			assert.Equal(
				t,
				isResultLine(testCase.in),
				testCase.out,
			)
		})
	}
}

func TestGetTestNameFromStatusLine(t *testing.T) {
	t.Parallel()

	testCases := []struct {
		name string
		in   string
		out  string
	}{
		{
			"BaseCase",
			"=== RUN   TestGetTestNameFromStatusLine",
			"TestGetTestNameFromStatusLine",
		},
		{
			"Indented",
			"    === RUN   TestGetTestNameFromStatusLine/Indented",
			"TestGetTestNameFromStatusLine/Indented",
		},
		{
			"SpecialChars",
			"=== RUN   TestGetTestNameFromStatusLine/SpecialChars---_FAIL",
			"TestGetTestNameFromStatusLine/SpecialChars---_FAIL",
		},
		{
			"WhenPaused",
			"=== PAUSE TestGetTestNameFromStatusLine",
			"TestGetTestNameFromStatusLine",
		},
		{
			"WhenCont",
			"=== CONT  TestGetTestNameFromStatusLine",
			"TestGetTestNameFromStatusLine",
		},
	}

	for _, testCase := range testCases {
		testCase := testCase
		t.Run(testCase.name, func(t *testing.T) {
			assert.Equal(
				t,
				getTestNameFromStatusLine(testCase.in),
				testCase.out,
			)
		})
	}
}

func TestIsStatusLine(t *testing.T) {
	t.Parallel()

	testCases := []struct {
		name string
		in   string
		out  bool
	}{
		{
			"BaseCase",
			"=== RUN   TestGetTestNameFromStatusLine",
			true,
		},
		{
			"Indented",
			"    === RUN   TestGetTestNameFromStatusLine/Indented",
			true,
		},
		{
			"SpecialChars",
			"=== RUN   TestGetTestNameFromStatusLine/SpecialChars---_FAIL",
			true,
		},
		{
			"WhenPaused",
			"=== PAUSE TestGetTestNameFromStatusLine",
			true,
		},
		{
			"WhenCont",
			"=== CONT  TestGetTestNameFromStatusLine",
			true,
		},
		{
			"NonStatusLine",
			"--- FAIL: TestIsStatusLine",
			false,
		},
	}

	for _, testCase := range testCases {
		testCase := testCase
		t.Run(testCase.name, func(t *testing.T) {
			assert.Equal(
				t,
				isStatusLine(testCase.in),
				testCase.out,
			)
		})
	}
}

func TestIsSummaryLine(t *testing.T) {
	t.Parallel()

	testCases := []struct {
		name string
		in   string
		out  bool
	}{
		{
			"BaseCase",
			"ok  	github.com/gruntwork-io/terratest/test	812.034s",
			true,
		},
		{
			"NotSummary",
			"--- FAIL: TestIsStatusLine",
			false,
		},
	}

	for _, testCase := range testCases {
		testCase := testCase
		t.Run(testCase.name, func(t *testing.T) {
			assert.Equal(
				t,
				isSummaryLine(testCase.in),
				testCase.out,
			)
		})
	}
}

func TestIsPanicLine(t *testing.T) {
	t.Parallel()

	testCases := []struct {
		name string
		in   string
		out  bool
	}{
		{
			"BaseCase",
			"panic: error [recovered]",
			true,
		},
		{
			"NotPanic",
			"--- FAIL: TestIsStatusLine",
			false,
		},
	}

	for _, testCase := range testCases {
		testCase := testCase
		t.Run(testCase.name, func(t *testing.T) {
			assert.Equal(
				t,
				isPanicLine(testCase.in),
				testCase.out,
			)
		})
	}
}

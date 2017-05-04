// @flow

import React from 'react'
import SubmissionGrader from '../SubmissionGrader'
import renderer from 'react-test-renderer'

jest
  .mock('../../../common/components/BottomDrawer', () => 'BottomDrawer')
  .mock('SegmentedControlIOS', () => 'SegmentedControlIOS')
  .mock('../components/GradePicker')
  .mock('../components/Header')
  .mock('../components/FilesTab')
  .mock('../components/RubricDetails')
  .mock('../comments/CommentsTab')

let defaultProps = {
  submissionID: '1',
  submissionProps: {},
}

describe('SubmissionGrader', () => {
  beforeEach(() => {
    jest.resetAllMocks()
  })

  it('renders', () => {
    let tree = renderer.create(
      <SubmissionGrader {...defaultProps} />
    ).toJSON()

    expect(tree).toMatchSnapshot()
  })

  it('switches between different tabs', () => {
    let tree = renderer.create(
      <SubmissionGrader {...defaultProps} />
    )

    let instance = tree.getInstance()
    let event = {
      nativeEvent: {
        selectedSegmentIndex: 0,
      },
    }
    instance.changeTab(event)
    expect(instance.state.selectedTabIndex).toEqual(0)

    event.nativeEvent.selectedSegmentIndex = 1
    instance.changeTab(event)
    expect(instance.state.selectedTabIndex).toEqual(1)

    event.nativeEvent.selectedSegmentIndex = 2
    instance.changeTab(event)
    expect(instance.state.selectedTabIndex).toEqual(2)
  })
})

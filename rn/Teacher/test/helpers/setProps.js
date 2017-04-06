/* @flow */

export default function setProps<P> (component: any, changedProps: P): void {
  const instance = component.getInstance()
  const nextProps = {
    ...instance.props,
    ...changedProps,
  }
  if (instance.componentWillReceiveProps) {
    instance.componentWillReceiveProps(nextProps)
  }
  instance.props = nextProps
}

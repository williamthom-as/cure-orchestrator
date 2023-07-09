import moment from 'moment';

export class TimeAgoValueConverter {
  toView(value) {
    return moment(value, 'YYYY-MM-DD hh:mm:ss z').fromNow();
  }
}

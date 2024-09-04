enum RideStatus {
  pending,
  accepted,
  arriving,
  arrived,
  inProgress,
  completed,
  canceled
}

// ride status to enum
RideStatus rideStatusToEnum(String status) {
  switch (status) {
    case 'pending':
      return RideStatus.pending;
    case 'accepted':
      return RideStatus.accepted;
    case 'arriving':
      return RideStatus.arriving;
    case 'arrived':
      return RideStatus.arrived;
    case 'in_progress':
      return RideStatus.inProgress;
    case 'completed':
      return RideStatus.completed;
    case 'canceled':
      return RideStatus.canceled;
    default:
      return RideStatus.pending;
  }
}

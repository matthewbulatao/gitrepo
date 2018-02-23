<input type="hidden" id="checkInDraft" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${sessionScope.reservationDraft.checkIn}"/>" />
<input type="hidden" id="checkOutDraft" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${sessionScope.reservationDraft.checkOut}"/>" />

<input type="hidden" name="countAdult" value="${sessionScope.reservationDraft.countAdult}" />
<input type="hidden" name="countChildren" value="${sessionScope.reservationDraft.countChildren}" />
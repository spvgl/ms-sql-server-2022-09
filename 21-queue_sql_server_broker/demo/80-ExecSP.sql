
SELECT InvoiceId, InvoiceConfirmedForProcessing, *
FROM Sales.Invoices
WHERE InvoiceID = 61231;

--Send message
EXEC Sales.SendNewInvoice
	@invoiceId = 61231;

SELECT CAST(message_body AS XML),*
FROM dbo.TargetQueueWWI;

SELECT CAST(message_body AS XML),*
FROM dbo.InitiatorQueueWWI;

--Target
EXEC Sales.GetNewInvoice;

--Initiator
EXEC Sales.ConfirmInvoice;

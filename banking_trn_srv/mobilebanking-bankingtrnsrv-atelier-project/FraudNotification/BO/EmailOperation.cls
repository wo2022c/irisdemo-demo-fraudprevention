/// -----------------------------------------------------------------------------
/// Messaging + Operation classes to notify a client by e‑mail lorsqu’une fraude
/// est détectée. À placer dans le même namespace que la production.
/// -----------------------------------------------------------------------------


/// Business Operation qui envoie l’e‑mail via SMTP
Class FraudNotification.BO.EmailOperation Extends Ens.BusinessOperation
{
Property Adapter As EnsLib.EMail.OutboundAdapter;

Parameter ADAPTER = "EnsLib.EMail.OutboundAdapter";

Parameter INVOCATION = "Queue";

Method SendEmail(pRequest As FraudNotification.EmailReq, Output pResponse As Ens.Response) As %Status [ Language = python ]
{
    import iris
    try:
        email_addr = pRequest.EmailAddress or f"{pRequest.AccountId}@bankdemo.com"

        subject = f"Alerte fraude sur votre compte #{pRequest.AccountId}"

        body = (
            "Bonjour,\n\n"
            "Nous avons bloqué une transaction suspecte :\n\n"
            f"Numéro   : {pRequest.TransactionNumber}\n"
            f"Montant  : {pRequest.Amount}\n"
            f"Date     : {pRequest.TransDateTime}\n"
            f"Raison   : {pRequest.FraudReason}\n\n"
            "Si vous reconnaissez cette opération, merci de contacter le service client.\n\n"
            "— Banque Démo"
        )

        sc = iris.cls(self.Adapter.__class__).SendMail(email_addr, subject, body)
        return sc

    except Exception as ex:
        StatusException = iris.cls('%Exception.StatusException')
        return StatusException.CreateFromException(ex)
}


XData MessageMap
{
<MapItems>
    <MapItem MessageType="dc.Demo.PostMessage">
        <Method>SendEmail</Method>
    </MapItem>
</MapItems>
}

}

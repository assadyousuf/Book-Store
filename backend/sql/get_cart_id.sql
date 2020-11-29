/* Using a username & password, collect their cartid */
SELECT Has.cartid FROM (
    Has
    INNER JOIN
    (
        SELECT username
        FROM UserAccount
        WHERE
            UserAccount.username=%s
            AND
            UserAccount.passwordHash=%s
    ) as RequestedUserAcc
    ON RequestedUserAcc.username = Has.username
);

/* Inline */
SELECT Has.cartid FROM ( Has INNER JOIN ( SELECT username FROM UserAccount WHERE UserAccount.username=%s AND UserAccount.passwordHash=%s ) as RequestedUserAcc ON RequestedUserAcc.username = Has.username );
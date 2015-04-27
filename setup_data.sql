
-- addon-self-administration client

INSERT INTO osiam_client (internal_id, accesstokenvalidityseconds, client_secret, expiry,
id, implicit_approval, redirect_uri, refreshtokenvalidityseconds,
validityinseconds)
VALUES (1, 2342, 'super-secret', null, 'addon-self-administration-client', FALSE, 'http://localhost:8080/addon-self-administration', 4684, 1337);

-- client scopes and grants

INSERT INTO osiam_client_scopes (id, scope) VALUES (1, 'GET');
INSERT INTO osiam_client_scopes (id, scope) VALUES (1, 'POST');
INSERT INTO osiam_client_scopes (id, scope) VALUES (1, 'PUT');
INSERT INTO osiam_client_scopes (id, scope) VALUES (1, 'PATCH');
INSERT INTO osiam_client_scopes (id, scope) VALUES (1, 'DELETE');
INSERT INTO osiam_client_grants (id, grants) VALUES (1, 'authorization_code');
INSERT INTO osiam_client_grants (id, grants) VALUES (1, 'refresh_token');
INSERT INTO osiam_client_grants (id, grants) VALUES (1, 'password');
INSERT INTO osiam_client_grants (id, grants) VALUES (1, 'client_credentials');

-- addon-administration client

INSERT INTO osiam_client (internal_id, accesstokenvalidityseconds, client_secret, expiry,
id, implicit_approval, redirect_uri, refreshtokenvalidityseconds,
validityinseconds)
VALUES (2, 2342, 'super-secret', null, 'addon-administration-client', FALSE, 'http://localhost:8080/addon-administration', 4684, 1337);

-- client scopes and grants

INSERT INTO osiam_client_scopes (id, scope) VALUES (2, 'GET');
INSERT INTO osiam_client_scopes (id, scope) VALUES (2, 'POST');
INSERT INTO osiam_client_scopes (id, scope) VALUES (2, 'PUT');
INSERT INTO osiam_client_scopes (id, scope) VALUES (2, 'PATCH');
INSERT INTO osiam_client_scopes (id, scope) VALUES (2, 'DELETE');
INSERT INTO osiam_client_grants (id, grants) VALUES (2, 'authorization_code');
INSERT INTO osiam_client_grants (id, grants) VALUES (2, 'refresh_token');
INSERT INTO osiam_client_grants (id, grants) VALUES (2, 'password');
INSERT INTO osiam_client_grants (id, grants) VALUES (2, 'client_credentials');

-- resource server: example group 'admin' for the addon-administration

INSERT INTO scim_meta (id, created, lastmodified, location, resourcetype, version)
VALUES (2, '2011-10-10', '2011-10-10', NULL, 'Group', NULL);

INSERT INTO scim_id (internal_id, external_id, id, meta_id)
VALUES (2, 'group_external_id', 'cef9452e-00a9-4cec-a086-d171374aabef', 2);

INSERT INTO scim_group (displayname, internal_id)
VALUES ('admin', 2);

-- resource server: add user to group

INSERT INTO scim_group_scim_id (groups_internal_id, members_internal_id)
VALUES (2, 1);

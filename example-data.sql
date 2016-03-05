INSERT INTO scim_meta (
  id, created, last_modified, location, resource_type, version
) VALUES (
  1, '2011-10-10', '2011-10-10', NULL, 'User', NULL
);
INSERT INTO scim_id (
  internal_id, external_id, id, meta
) VALUES (
  1, NULL, 'cef9452e-00a9-4cec-a086-d171374ffbef', 1
);
INSERT INTO scim_user (
  active, display_name, locale, nick_name, preferred_language, profile_url,
  timezone, title, user_name, user_type, internal_id, name,
  password
) VALUES (
  TRUE, NULL, NULL, NULL, NULL, NULL,
  NULL, NULL, 'admin', NULL, 1, NULL,
  'cbae73fac0893291c4792ef19d158a589402288b35cb18fb8406e951b9d95f6b8b06a3526ffebe96ae0d91c04ae615a7fe2af362763db386ccbf3b55c29ae800'
);
INSERT INTO osiam_client (
  internal_id, access_token_validity_seconds, client_secret, id,
  implicit_approval, redirect_uri, refresh_token_validity_seconds, validity_in_seconds
) VALUES (
  1, 28800, 'secret', 'example-client',
  FALSE, 'http://localhost:5000/oauth2', 86400, 28800
);
INSERT INTO osiam_client_scopes (id, scope) VALUES (1, 'ADMIN');
INSERT INTO osiam_client_scopes (id, scope) VALUES (1, 'ME');
INSERT INTO osiam_client_grants (id, grants) VALUES (1, 'authorization_code');
INSERT INTO osiam_client_grants (id, grants) VALUES (1, 'refresh_token');
INSERT INTO osiam_client_grants (id, grants) VALUES (1, 'password');
INSERT INTO osiam_client_grants (id, grants) VALUES (1, 'client_credentials');

SELECT 
  o.[tag_name]
  ,o.[hierarchical_name],
  u.user_profile_name
  FROM [dbo].[gobject] as o
  Join [dbo].[user_profile] as u 
  on o.checked_out_by_user_guid = u.user_guid

--Copy and Paste the Results of this script into a text file
--and load that file into object viewer

Declare @rootAppEngId int

CREATE TABLE #Attribs(attrib varchar(150))

INSERT  INTO #Attribs (attrib) VALUES 
------------------------------------------------
--Configure Required Attributes below
------------------------------------------------
('.Engine.Historian.ConnectState'),
('.Scheduler.TimeIdleAvg'),
('.Engine.ProcessCPULoad'),
('.Scheduler.ScanOverrunsConsecCnt')
------------------------------------------------
SELECT @rootAppEngId = [template_definition_id]
  FROM [dbo].[template_definition]
  Where original_template_tagname = '$AppEngine'

SELECT(
SELECT 'Engine Audit' as "Tab", (
  SELECT t1.[hierarchical_name] + t2.attrib as ReferenceString
  FROM [dbo].[gobject] as t1
  JOIN #Attribs as t2
  on 1 = 1
  where t1.template_definition_id = @rootAppEngId 
  AND t1.[is_template] = 0
  AND t1.deployed_package_id <> 0
  ORDER BY ReferenceString
  FOR XML PATH(''), type
 ) FOR XML RAW('Watch'), type
 ) FOR XML RAW('VisualLMXTestTool')
 
DROP TABLE #Attribs

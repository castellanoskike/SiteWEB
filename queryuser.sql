 CREATE proc rpt.ResumByUser 
 ( @iduser nvarchar(50)= null ,
 @StatusClosed nvarchar(20)= null )
 as
 SELECT top(100)   
 e.IdEmployee AS [IdUsuario],   
 e.Name AS [Nombre],   
 COUNT( f.IdFiveSs) AS [Total_Auditorias_Fives],  
 COUNT( CASE WHEN f.ProcessStatus = 'PENDING' THEN f.ProcessStatus END)
AS [Total_Auditorias_Fives_Abiertas],  
 COUNT( CASE WHEN f.ProcessStatus = 'EXPIRED' 
 THEN f.ProcessStatus END) AS [Total_Auditorias_Fives_EXPIRED],  
 COUNT( CASE WHEN f.ProcessStatus = 'FINISHED'  THEN f.ProcessStatus END)
 AS [Total_Auditorias_Fives_Cerradas],   COUNT( CASE WHEN c.StatusClosed = 'CLOSED' THEN c.StatusClosed END) AS [Acciones_Cerradas],  
COUNT( CASE WHEN c.StatusClosed = 'PENDING' THEN c.StatusClosed END) 
AS [Acciones_Abiertas] FROM      [dbo].[EmployeeNames] e 
LEFT JOIN      [dbo].[FiveSs] f ON e.IdEmployee = f.CreatedBy
 LEFT JOIN  [dbo].[FiveSsCorrectiveAction] c ON e.IdEmployee = c.AsiganatedTo  
 where  (f.CreatedBy =@iduser or @iduser is null)  
 and ( c.StatusClosed = @StatusClosed or @StatusClosed is null) GROUP BY    
 e.IdEmployee, 
 e.Name ORDER BY      e.Name;   